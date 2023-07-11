    " Map <leader> space space to open terminal and call 'aider'
    nmap <leader><Space><Space> :call OpenAider()<CR>

    function! s:OpenWindow(window_type)
        " Create a new buffer for the terminal
        let l:buf = nvim_create_buf(v:false, v:true)
        " Open the terminal in the preferred window type
        if a:window_type == 'vsplit'
            vnew 
        elseif a:window_type == 'hsplit'
            new 
        else
            " Calculate the size and position of the floating window
            let l:width = nvim_win_get_width(0) - 10
            let l:height = nvim_win_get_height(0) - 10
            let l:row = 2
            let l:col = 2
            " Create a new floating window for the terminal
            let l:win = nvim_open_win(l:buf, v:true, {'relative': 'editor', 'width': l:width, 'height': l:height, 'row': l:row, 'col': l:col})
            " Make the terminal window active
            call nvim_set_current_win(l:win)
            " Set the buffer type to 'nofile'
        endif
        call setbufvar(l:buf, '&buftype', 'nofile')
    endfunction

    function! s:RunAider()
        " Open the terminal
        "execute 'terminal'
        call termopen(['aider'], {'on_exit': function('s:OnExit')})
    endfunction

    function! OpenAider()
        " Get the user's preferred window type
        let l:window_type = get(g:, 'aider_window_type', 'vsplit')
        " Open the window
        call s:OpenWindow(l:window_type)
        " Run 'aider'
        call s:RunAider()
    endfunction

    function! s:OnExit(job_id, data, event)
        " Close the terminal window when 'aider' exits
        call nvim_win_close(0, v:true)
    endfunction
