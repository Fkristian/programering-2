defmodule Huf do
  def run()do freq(text()) end

  def freq(sample) do
    sampleList = String.to_charlist(sample)
    freq(sampleList, Tree.tree_new(), sampleList)
  end


  def freq([], freqTree, fullText) do
    makeFreqTreeAmountSorted(freqTree, fullText)
  end
  def freq([char | rest], freqTree, fullText) do
    freqTree = Tree.tree_insert(char, freqTree)
    freq(rest, freqTree, fullText)
  end

  def makeFreqTreeAmountSorted(freqTree, fullText)do
    treeSortedByAmount = pickOut(freqTree, Tree.tree_new())
    listSorted = treeToList(treeSortedByAmount, [])
    huffTree= huffBuild(listSorted)
  #  IO.inspect(huffTree)
    decoderTree = buildingHuffList(huffTree, Tree.tree_new(), [])
    binaryList= encodingHuff(fullText, [], decoderTree)
    fromBiToCharHuff(huffTree, binaryList,[], huffTree)
  end
  def pickOut({:node, e, amount, l, r}, tree)do
      tree = Tree.tree_insert_amount_sorted({e,amount}, tree)
      tree = cond do
        l != :nil -> pickOut(l, tree)
        true -> tree
      end

      tree = cond do
        r != :nil -> pickOut(r, tree)
        true -> tree
      end

  end


  def treeToList({:node, e, amount, l, r}, list)do
    #put in rigth
    list = cond do
      r != :nil -> treeToList(r, list)
      true -> list
    end

    list = [{amount , e} | list]

    #put in curent
    list = cond do
      l != :nil -> treeToList(l, list)
      true -> list
    end

    #put in left
  end





  def buildingHuffList({_, {zero, one}}, wayCollectionTree, way) do

    wayCollectionTree = buildingHuffList(zero, wayCollectionTree,  [0 | way])
    buildingHuffList(one, wayCollectionTree, [1 | way])
  end

  def buildingHuffList({_, destination}, wayCollectionTree, way) do
    Tree.tree_insert_amount_sorted({way, destination}, wayCollectionTree)
  end

  def encodingHuff([], encoded, _)do reverse(encoded) end
  def encodingHuff([charToEncode | restToEncode], encoded, decodingTree) do
      binaryRepresentation = Tree.tree_find_amount(charToEncode, decodingTree)
      encoded = deconstructListIntoList(binaryRepresentation, encoded)
      encodingHuff(restToEncode, encoded, decodingTree)
  end

  def deconstructListIntoList([], list) do list end
  def deconstructListIntoList([head |tail], list) do
    deconstructListIntoList(tail, [head | list])

  end



  #def test()do
  #fromBiToCharHuff({39,{{16,{{8, {{4, 104}, {4, 101}}},{8, {{4, {{2, {{1, 103}, {1, 109}}}, {2, {{1, 97}, {1, 99}}}}}, {4, 116}}}}}, {23, {{10, {{4, 115}, {6, {{3, {{1, 117}, {2, {{1, 108}, {1, 119}}}}}, {3, 105}}}}}, {13, {{6, 32}, {7, {{3, 111}, {4, {{2, 100}, {2, 110}}}}}}}}}}}, [0,0,0], {39,{{16,{{8, {{4, 104}, {4, 101}}},{8, {{4, {{2, {{1, 103}, {1, 109}}}, {2, {{1, 97}, {1, 99}}}}}, {4, 116}}}}}, {23, {{10, {{4, 115}, {6, {{3, {{1, 117}, {2, {{1, 108}, {1, 119}}}}}, {3, 105}}}}}, {13, {{6, 32}, {7, {{3, 111}, {4, {{2, 100}, {2, 110}}}}}}}}}}})
  #end
  def fromBiToCharHuff({_, letter}, [], list, decodingTree) do
    [letter | list]
  end

  def fromBiToCharHuff({_ , {zero, one}}, [head | tail], list,decodingTree) do
    cond do
      head == 0 -> fromBiToCharHuff(zero, tail, list,decodingTree)
      true -> fromBiToCharHuff(one, tail, list,decodingTree)
    end
  end

  def fromBiToCharHuff({_, letter}, [head | tail], list, decodingTree) do
    cond do
      head == 0 -> fromBiToCharHuff(decodingTree, tail, [letter | list],decodingTree)
      true -> fromBiToCharHuff(decodingTree, tail, [letter | list],decodingTree)
    end
  end

  def huffBuild([{firstAmount,firstHead}, {secondAmount, secondHead}| []])do
    {firstAmount + secondAmount,{{firstAmount,firstHead}, {secondAmount,secondHead}}}
  end



                              #[{1, 104}, {1, 97}, {1, 108}]
  def huffBuild([{firstAmount,firstHead}, {secondAmount, secondHead}| tail])do

    list = putInSorted({firstAmount + secondAmount, {{firstAmount,firstHead}, {secondAmount,secondHead}}}, tail)
    huffBuild(list)

  end

  def putInSorted({addAmount, x}, [])do [{addAmount, x}] end
  def putInSorted({addAmount, x}, [{listAmount, e} | tail])do

    cond do
      addAmount > listAmount -> [{listAmount, e} | putInSorted({addAmount, x}, tail)]
      true -> [{addAmount, x}, {listAmount, e} | tail]
    end

  end

  def reverse(e) do
    reverseR([] ,e)
  end
  def reverseR(e, []) do
    e
  end
  def reverseR(e, [head | tail]) do

    reverseR([head | e], tail)

  end


  #{39, {{16, {{8, {{4, 104}, {4, 101}}},     {8, {{4, {{2, {{1, 103}, {1, 109}}}, {2, {{1, 97}, {1, 99}}}}}, {4, 116}}}}}
   #{23, {{10,    {{4, 115}, {6, {{3, {{1, 117}, {2, {{1, 108}, {1, 119}}}}}, {3, 105}}}}}, {13, {{6, 32}, {7, {{3, 111}, {4, {{2, 100}, {2, 110}}}}}}}}}}}

 #[1, 1, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0, 1, 1, 1, 1, 0, 1, 0, 0, 1, 0, 1, 1,
  # 0, 0, 1, 0, 1, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, ...]

  def sample do
    "the quick brown fox jumps over the lazy dog
this is a sample text that we will use when we build
up a table we will only handle lower case letters and
no punctuation symbols the frequency will of course not
represent english but it is probably not that far off"
  end
  def text() do
    "this is something that we should encode"
  end



end







