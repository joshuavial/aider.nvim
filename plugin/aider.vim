    " Map <leader> space space to open terminal and call 'aider'
    nnoremap <leader><Space><Space> :call OpenAider()<CR>

    function! OpenAider()
        " Open a new terminal window
        vnew | terminal
        " Run 'aider'
        call jobsend(b:terminal_job_id, "aider\n")
    endfunction
