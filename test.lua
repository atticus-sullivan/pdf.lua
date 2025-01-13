local pdflib = require"pdflib"

local pdf = pdfe.open("./main.pdf")
print("pdf", pdf)

local page = pdfe.getpage(pdf, 1)
print("page", page, #page)
for i=1,#page,1 do
	print(i, pdfe.getfromdictionary(page, i))
end

local box = pdfe.getbox(page, "MediaBox")
print("box", box)
for k,v in pairs(box) do
	print(k,v)
end

local contents, dict = pdfe.getstream(page, "Contents")
print("contents", contents, dict)
print("length", dict.Length)
print("filter", dict.Filter)
local str, n = pdfe.readwholestream(page.Contents, true)

local extract = pdflib.new()
local extract_p = extract:new_page()

extract_p:stream_from_string(str)
extract_p:add()
extract:write("out.pdf")
