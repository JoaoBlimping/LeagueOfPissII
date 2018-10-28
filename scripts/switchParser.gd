extends Node

const WHITESPACE = [' ', '	', '\n']
const THINGS = ['!', '&', '|', '^', '(', ')']
const OPERATORS = ['!', '&', '|', '^']

static func tokenise(s):
	var tokens = []
	var start = -1
	s += ' '
	for i in range(s.length()):
		var c = s[i]
		if (not (c in WHITESPACE or c in THINGS) and start == -1):
			start = i
		if ((c in WHITESPACE or c in THINGS or i == s.length() - 1) and start != -1):
			tokens.push_back(s.substr(start, i - start))
			start = -1
		if (c in THINGS):
			tokens.push_back(c)
			start = -1
	return tokens

static func evaluationTree(tokens):
	var layer = 0
	var best = -1
	var bestLayer = 99999
	var switcher = true
	
	for i in range(tokens.size()):
		var token = tokens[i]
		if (token == '('): layer += 1
		elif (token == ')'): layer -= 1
		elif (token in OPERATORS):
			if ((layer < bestLayer) or switcher):
				best = i
				bestLayer = layer
				switcher = false
		elif (switcher and layer < bestLayer):
			best = i
			bestLayer = layer
	
	var left = []
	var right = []
	
	if (not switcher):
		for i in range(tokens.size()):
			if (i < best): left.append(tokens[i])
			if (i > best): right.append(tokens[i])
		
	var tree = {"type": tokens[best]}
	if (not left.empty()): tree["left"] = evaluationTree(left)
	if (not right.empty()): tree["right"] = evaluationTree(right)
	return tree
		
	

static func parseSwitches(s):
	var tokens = tokenise(s)
	return evaluationTree(tokens)