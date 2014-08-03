function remove_empty_comms!(M::Modular)
   S = M.S
   S = S[:,[1:size(S)[2]]'[sum(S,1).>0]]
   M.S = S
end

function reorder_by_module!(M::Modular)
   remove_empty_comms!(M)
   nA = zeros(M.A)
   nS = zeros(M.S)
   current_col = 1
   current_row = 1
   ncol = size(nA)[2]
   for m in 1:size(nS)[2]
      for col in 1:size(nA)[2]
         if M.S[col,m] > 0
            nA[:,current_col] = M.A[:,col]
            nS[current_col,:] = M.S[col,:]
            current_col += 1
         end
      end
   end
   for m in 1:size(nS)[2]
      for row in 1:size(nA)[1]
         if M.S[row+ncol,m] > 0
            nA[current_row,:] = M.A[row,:]
            nS[current_row+ncol,:] = M.S[row+ncol,:]
            current_row += 1
         end
      end
   end
   M.A = nA
   M.S = nS
end

function draw_matrix(M::Modular; reorder::Function = reorder_by_module!, file="modular.png")
   remove_empty_comms!(M)
   reorder(M)
   number_modules = size(M.S)[2]
   module_blue = linspace(0.0, 1.0, number_modules)
   nbot, ntop = size(M.A)
   width  = 4 + nbot*(10+4)
   height = 4 + ntop*(10+4)
   ## Initialize device
   c = CairoRGBSurface(width, height)
   cr = CairoContext(c)
   save(cr)
   ## Background
   set_source_rgba(cr, 1.0, 1.0, 1.0, 1.0)
   rectangle(cr, 0.0, 0.0, float(width), float(height))
   fill(cr)
   restore(cr)
   save(cr)
   ## Draw the blocks
   for top in 1:ntop
      for bot in 1:nbot
         if M.A[bot,top] > 0
            if sum(M.S[top,:] .* M.S[bot+ntop,:]) > 0
               m_id = [1:number_modules]'[bool(M.S[top,:])][1]
               set_source_rgb(cr, 0.0, 0.0, module_blue[m_id])
            else
               set_source_rgb(cr, 0.4, 0.4, 0.4)
            end
            rectangle(cr, 4 + (bot-1)*14, 4 + (top-1)*14, 10, 10)
            fill(cr)
            save(cr)
         end
      end
   end
   write_to_png(c, file)
end
