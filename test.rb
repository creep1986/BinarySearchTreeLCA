require 'pp'
require './binary_search_tree.rb'

arr = [5, 3, 8, 1, 4, 6, 10, 2, 7 ,9]
bintree = BinarySearchTree.new(arr)
pp bintree.lowest_common_ancestor(2, 1)
pp bintree.debug
