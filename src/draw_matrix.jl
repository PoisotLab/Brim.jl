function remove_empty_comms!(M::Modular)
   S = M.S
   S = S[:,[1:size(S)[2]]'[sum(S,1).>0]]
   M.S = S
end

function draw_matrix(M::Modular; reorder::Function = (x) -> x, file="modular.png")
   remove_empty_comms!(M)
   reorder(M)
   number_modules = size(M.S)[2]
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
               set_source_rgb(cr, 0.0, 0.0, 0.0)
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
