#!/usr/bin/perl

@contents = <STDIN>;              # Read it into an array

foreach $contents (@contents)
{
  $word1 = 'value=';
  $word2 = ' >';

$flag = 0;
while($contents =~ m/$word1/)
{
  chomp($contents);
  $index_word1 = index($contents,$word1);

  $contents = substr($contents,$index_word1+7,length($contents)- $index_word1);

  $index_word2 = index($contents,$word2);
  ##foreach $index_word1 (@index_word1)


  $sub_file = substr($contents,0,$index_word2-1 );

        if ($flag == 0)
        {
                print $sub_file."\n";
                $flag = 1;
        }
        else
        {
                $flag = 0;
        }
   $contents = substr($contents, $index_word2,length($contents)-$index_word2);
};
};

