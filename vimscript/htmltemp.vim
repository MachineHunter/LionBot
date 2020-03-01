function! ChooseTemp(select)
	if a:select=="html"
		return "<!DOCTYPE html>\n<html>\n\t<head>\n\t<title></title>\n<%= csrf_meta_tags %>\n<%= stylesheet_link_tag '', 'data-turbolinks-track': 'reload' %>\n<%= javascript_include_tag '', 'data-turbolinks-track': 'reload' %>\n\b</head>\n\n<body>\n\t<%= yield %>\n\b</body>\n\b</html>"
	
	elseif a:select=="table"
		return "<table>\n\t<tr>\n\t<th></th>\n<td><%=  %></td>\n\b</tr>\n\n\b</table>"

	elseif a:select=="href"
		return '<a href="/<%=  %>"> </a>'

	elseif a:select=="err"
		return "<% if @___.errors.any? %>\n<ul>\n\t<% @___.errors.full_messages.each do |err| %>\n\t<li><%= err %></li>\n\b<% end %>\n\b</ul>\n<% end %>"
	
	elseif a:select=="ff"
		return "<%= form_for(@___, url:\{controller:'', action:''\}) do |form| %>\n<% end %>"

	elseif a:select=="per"
		return "<%  %>"
	
	elseif a:select=="pere"
		return "<%=  %>"
	
	elseif a:select=="end"
		return "<% end %>"
	
	else
		return "<" . a:select . "></" . a:select . ">"
	end if
endfunction


function! ExecCommand(select)
	execute ":normal a" . ChooseTemp(a:select)
endfunction


function! HelpPrint()
	echo "html      ==> template of html erb layout"
	echo "table     ==> template of table"
	echo "href      ==> a tag with href"
	echo "err       ==> validation error template for html.erb"
	echo "ff        ==> form_for template"
	echo "per       ==> <%  %>"
	echo "pere      ==> <%=  %>"
	echo "end       ==> <% end %>"
	echo "[others]  ==> <other></other>"
endfunction

command! -nargs=1 Temp call ExecCommand(<f-args>)
command! -nargs=0 Help call HelpPrint()

