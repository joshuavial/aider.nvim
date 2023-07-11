    " Map <leader> space space to open terminal and call 'aider'
    nnoremap <leader><Space><Space> :call OpenAider()<CR>

    function! OpenAider()
        " Create a new buffer for the terminal
        let l:buf = nvim_create_buf(v:false, v:true)
        " Create a new floating window for the terminal
        let l:win = nvim_open_win(l:buf, v:true, {'relative': 'editor', 'width': 80, 'height': 24, 'row': 10, 'col': 10})
        " Run 'aider' in the terminal
        call termopen('aider', {'on_exit': function('s:OnExit')})
        " Make the terminal window active
        call nvim_set_current_win(l:win)
    endfunction

    function! s:OnExit(job_id, data, event)
        " Close the terminal window when 'aider' exits
        call nvim_win_close(0, v:true)
    endfunction
