# Counting elementary divisors of nonprimitive linear cycles

# Importing numpy as np
import numpy as np
import operator
# ========================================================================
# ========================================================================
def dict2tex(dict):
	text			= ""
	sep				= " \cdot "
	for div in sorted(dict.keys()):
		if(div != 0):
			text = text + str(div) + "^{" + str(dict.get(div)) + "}" + sep

	text = "$" + replace_last(text, sep, '') + "$"
	return text

def replace_last(s, old, new):
	li = s.rsplit(old, 1)
	return new.join(li)
# ========================================================================
# ========================================================================

# Set the folder where the files are located
parent_dir		= "../../main_data/linear_cycles/smith_form/primitive/"
result_folder	= "../../main_data/linear_cycles/elementary_divisors/"

# Setting cases we want to count
n_arr		= np.array([2, 4])
d_arr_min	= np.array([3, 3]) 
d_arr_max	= np.array([14, 6])

result_arxiv = open(result_folder + "primitive_elementary_divisors_table.tex", 'w')

# Preamble of tex file
result_arxiv.write("\\begin{table}[ht!]\n\\centering\n\\begin{tabular}{ll}\n\\hline\n")
result_arxiv.write("\\multicolumn{1}{ | l | }{$(n, d)$}" + 3*"\t"+ "& \\multicolumn{1}{l | }{Elementary Divisors (Primitive Cycles)}" + 5*"\t"+"\\hline\n")

for s in np.arange(0, len(n_arr)):
	n = n_arr[s]
	for d in np.arange(d_arr_min[s], d_arr_max[s] + 1):
		# Setting filename
		basic_filename	= "n_" + str(n) + "_d_" + str(d) + "_inv_factors_diag.txt"
		filename		= parent_dir + basic_filename
		arxiv			= open(filename, 'r')
		arxiv_text		= arxiv.read()
		divisors_raw	= arxiv_text.split("\n")
		divisors_raw 	= list(map(int, divisors_raw))

		# Construct dictionary
		Div = dict()
		for divisor in divisors_raw:
			Div[divisor] = Div.get(divisor, 0) + 1

		# Write tex file
		divisors_latex = dict2tex(Div)
		result_arxiv.write("\\multicolumn{1}{ | l | }{$(" + str(n) + "," + str(d) + ")$}" + 3*"\t" +  "& \\multicolumn{1}{l | }{" )
		result_arxiv.write(divisors_latex)
		result_arxiv.write("}\\\\ \\hline\n")


result_arxiv.write("\\end{tabular}\n\\caption{Non-primitive Elementary Divisors}\n\\label{non-primitive-elementary-divs}\n\\end{table}")
result_arxiv.close()


