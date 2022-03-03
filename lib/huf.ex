defmodule Huf do
  def run()do freq(text()) end

  def bench(n)do
    {e, textInPut} = File.read("text.txt")
    {binaryList, huffTree}= encode(textInPut)
#
    charList = String.to_charlist(textInPut)
    freqTree = freqTree(charList)
    treeSortedByAmount = pickOut(freqTree, Tree.tree_new())
    listSorted = treeToList(treeSortedByAmount, [])
    huffTree= huffBuild(listSorted)
    decoderTree = buildingHuffList(huffTree, Tree.tree_new(), [])


    avgTime = (bench(n, charList,decoderTree, 0) / n)
    IO.inspect("Encode")
    IO.inspect(avgTime)
#    avgTime = (benchD(n, binaryList, huffTree, 0) / n)
#    IO.inspect("Decode")
#    IO.inspect(avgTime)
    :ok
  end
  def bench(0, charList, decoderTree, elapsedTime)do
    elapsedTime
  end

  def bench(n, charList, decoderTree, elapsedTime)do
    {time_in_microseconds, _} =:timer.tc(fn -> encodingHuff(charList, [], decoderTree) end)
    avgTime = bench(n - 1, charList, decoderTree, elapsedTime + time_in_microseconds)
  end
  def benchD(0, textInput, elapsedTime)do
    elapsedTime
  end

  def benchD(n, binaryList, huffTree, elapsedTime)do
    {time_in_microseconds, _} =:timer.tc(fn -> decode(binaryList, huffTree) end)
    avgTime = benchD(n - 1, binaryList, huffTree, elapsedTime + time_in_microseconds)
  end

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

  def freqTree(sample) do
    freqTree(sample, Tree.tree_new(), sample)
  end

  def freqTree([], freqTree, fullText) do
    freqTree
  end
  def freqTree([char | rest], freqTree, fullText) do
    freqTree = Tree.tree_insert(char, freqTree)
    freqTree(rest, freqTree, fullText)
  end




  def encode(textInput)do
    charList = String.to_charlist(textInput)
    freqTree = freqTree(charList)
    treeSortedByAmount = pickOut(freqTree, Tree.tree_new())
    listSorted = treeToList(treeSortedByAmount, [])
    huffTree= huffBuild(listSorted)
    decoderTree = buildingHuffList(huffTree, Tree.tree_new(), [])
    binaryList= encodingHuff(charList, [], decoderTree)
    {binaryList, huffTree}

  end

  def decode(binaryList, huffTree)do
    fromBiToCharHuff(huffTree, binaryList,[], huffTree)
  end

  def makeFreqTreeAmountSorted(freqTree, fullText)do
    treeSortedByAmount = pickOut(freqTree, Tree.tree_new())
  #  IO.inspect(treeSortedByAmount)
    listSorted = treeToList(treeSortedByAmount, [])
   # IO.inspect(listSorted)
    huffTree= huffBuild(listSorted)
      IO.inspect(huffTree)
    decoderTree = buildingHuffList(huffTree, Tree.tree_new(), [])
    IO.inspect(decoderTree)
    binaryList= encodingHuff(fullText, [], decoderTree)
    #IO.inspect(binaryList)
    #IO.inspect(" -> ")
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
    list = cond do
      r != :nil -> treeToList(r, list)
      true -> list
    end

    list = [{amount , e} | list]

    list = cond do
      l != :nil -> treeToList(l, list)
      true -> list
    end

  end





  def buildingHuffList({_, {zero, one}}, wayCollectionTree, way) do

    wayCollectionTree = buildingHuffList(zero, wayCollectionTree,  [0 | way])
    buildingHuffList(one, wayCollectionTree, [1 | way])
  end

  def buildingHuffList({_, destination}, wayCollectionTree, way) do
    Tree.tree_insert_amount_sorted({reverse(way), destination}, wayCollectionTree)
  end

  def encodingHuff([], encoded, _)do encoded end
  def encodingHuff([charToEncode | restToEncode], encoded, decodingTree) do
      binaryRepresentation = Tree.tree_find_amount(charToEncode, decodingTree)
      encoded = deconstructListIntoList(binaryRepresentation, encoded)
      encodingHuff(restToEncode, encoded, decodingTree)
  end

  def deconstructListIntoList([], list) do list end
  def deconstructListIntoList([head |tail], list) do
      deconstructListIntoList(tail, [head | list])
  end



  def fromBiToCharHuff({_, letter}, [], list, decodingTree) do
    [letter | list]
  end
  def fromBiToCharHuff({_ , {zero, one}}, [head | tail], list,decodingTree) do
    cond do
      head == 0 -> fromBiToCharHuff(zero, tail, list,decodingTree)
      true -> fromBiToCharHuff(one, tail, list,decodingTree)
    end
  end
  def fromBiToCharHuff({_, letter}, binaryList, list, decodingTree) do
    fromBiToCharHuff(decodingTree, binaryList, [letter | list],decodingTree)
  end

  def huffBuild([{firstAmount,firstHead}, {secondAmount, secondHead}| []])do
    {firstAmount + secondAmount,{{firstAmount,firstHead}, {secondAmount,secondHead}}}
  end


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

