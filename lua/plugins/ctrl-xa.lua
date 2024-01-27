return {
	"Konfekt/vim-CtrlXA",
	cond = true,
	config = function()
		vim.cmd([[
      let g:CtrlXA_Toggles = [
        \ ["public", "protected", "private"],
        \ ] + g:CtrlXA_Toggles
    ]])

		vim.cmd([[
      nmap <Plug>SpeedDatingFallbackUp   <Plug>(CtrlXA-CtrlA)
      nmap <Plug>SpeedDatingFallbackDown <Plug>(CtrlXA-CtrlX)
    ]])
	end,
}
