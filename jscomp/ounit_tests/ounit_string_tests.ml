let ((>::),
     (>:::)) = OUnit.((>::),(>:::))

let (=~) = OUnit.assert_equal    




let suites = 
  __FILE__ >::: 
  [
    __LOC__ >:: begin fun _ ->
      OUnit.assert_bool "not found " (Ext_string.rindex_neg "hello" 'x' < 0 )
    end;

    __LOC__ >:: begin fun _ -> 
      Ext_string.rindex_neg "hello" 'h' =~ 0 ;
      Ext_string.rindex_neg "hello" 'e' =~ 1 ;
      Ext_string.rindex_neg "hello" 'l' =~ 3 ;
      Ext_string.rindex_neg "hello" 'l' =~ 3 ;
      Ext_string.rindex_neg "hello" 'o' =~ 4 ;
    end;

    __LOC__ >:: begin fun _ -> 
      OUnit.assert_bool "empty string" (Ext_string.rindex_neg "" 'x' < 0 )
    end;

    __LOC__ >:: begin fun _ -> 
      OUnit.assert_bool __LOC__
        (Ext_string.for_all_range "xABc"~start:1
           ~finish:2 (function 'A' .. 'Z' -> true | _ -> false));
      OUnit.assert_bool __LOC__
        (not (Ext_string.for_all_range "xABc"~start:1
                ~finish:3(function 'A' .. 'Z' -> true | _ -> false)));
      OUnit.assert_bool __LOC__
        ( (Ext_string.for_all_range "xABc"~start:1
             ~finish:2 (function 'A' .. 'Z' -> true | _ -> false)));
      OUnit.assert_bool __LOC__
        ( (Ext_string.for_all_range "xABc"~start:1
             ~finish:1 (function 'A' .. 'Z' -> true | _ -> false)));
      OUnit.assert_bool __LOC__
        ( (Ext_string.for_all_range "xABc"~start:1
             ~finish:0 (function 'A' .. 'Z' -> true | _ -> false)));    
      OUnit.assert_raise_any       
        (fun _ ->  (Ext_string.for_all_range "xABc"~start:1
                      ~finish:4 (function 'A' .. 'Z' -> true | _ -> false)));    

    end;

    __LOC__ >:: begin fun _ -> 
      OUnit.assert_bool __LOC__ @@
      List.for_all Ext_string.is_valid_source_name
        ["x.ml"; "x.mli"; "x.re"; "x.rei"; "x.mll"; 
         "A_x.ml"; "ab.ml"; "a_.ml"; "a__.ml";
         "ax.ml"];
      OUnit.assert_bool __LOC__ @@ not @@
      List.exists Ext_string.is_valid_source_name
        [".re"; ".rei";"..re"; "..rei"; "..ml"; ".mll~"; 
         "...ml"; "_.mli"; "_x.ml"; "__.ml"; "__.rei"; 
         ".#hello.ml"; ".#hello.rei"; "a-.ml"; "a-b.ml"; "-a-.ml"
        ; "-.ml"
        ]
    end;
    __LOC__ >:: begin fun _ -> 
      Ext_string.find ~sub:"hello" "xx hello xx" =~ 3 ;
      Ext_string.rfind ~sub:"hello" "xx hello xx" =~ 3 ;
      Ext_string.find ~sub:"hello" "xx hello hello xx" =~ 3 ;
      Ext_string.rfind ~sub:"hello" "xx hello hello xx" =~ 9 ;
    end;
    __LOC__ >:: begin fun _ -> 
      Ext_string.non_overlap_count ~sub:"0" "1000,000" =~ 6;
      Ext_string.non_overlap_count ~sub:"0" "000000" =~ 6;
      Ext_string.non_overlap_count ~sub:"00" "000000" =~ 3;
      Ext_string.non_overlap_count ~sub:"00" "00000" =~ 2
    end;
    __LOC__ >:: begin fun _ -> 
      OUnit.assert_bool __LOC__ (Ext_string.contain_substring "abc" "abc");
      OUnit.assert_bool __LOC__ (Ext_string.contain_substring "abc" "a");
      OUnit.assert_bool __LOC__ (Ext_string.contain_substring "abc" "b");
      OUnit.assert_bool __LOC__ (Ext_string.contain_substring "abc" "c");
      OUnit.assert_bool __LOC__ (Ext_string.contain_substring "abc" "");
      OUnit.assert_bool __LOC__ (not @@ Ext_string.contain_substring "abc" "abcc");
    end;
    __LOC__ >:: begin fun _ -> 
      Ext_string.trim " \t\n" =~ "";
      Ext_string.trim " \t\nb" =~ "b";
      Ext_string.trim "b \t\n" =~ "b";
      Ext_string.trim "\t\n b \t\n" =~ "b";            
    end;
    __LOC__ >:: begin fun _ -> 
      Ext_string.starts_with "ab" "a" =~ true;
      Ext_string.starts_with "ab" "" =~ true;
      Ext_string.starts_with "abb" "abb" =~ true;
      Ext_string.starts_with "abb" "abbc" =~ false;
    end;
    __LOC__ >:: begin fun _ -> 
      Ext_string.ends_with_then_chop "xx.ml"  ".ml" =~ Some "xx";
      Ext_string.ends_with_then_chop "xx.ml" ".mll" =~ None
    end;
    __LOC__ >:: begin fun _ -> 
      Ext_string.starts_with_and_number "js_fn_mk_01" ~offset:0 "js_fn_mk_" =~ 1 ;
      Ext_string.starts_with_and_number "js_fn_run_02" ~offset:0 "js_fn_mk_" =~ -1 ;
      Ext_string.starts_with_and_number "js_fn_mk_03" ~offset:6 "mk_" =~ 3 ;
      Ext_string.starts_with_and_number "js_fn_mk_04" ~offset:6 "run_" =~ -1;
      Ext_string.starts_with_and_number "js_fn_run_04" ~offset:6 "run_" =~ 4;
      Ext_string.(starts_with_and_number "js_fn_run_04" ~offset:6 "run_" = 3) =~ false 
    end;
    __LOC__ >:: begin fun _ -> 
      Ext_string.for_all (function '_' -> true | _ -> false)
        "____" =~ true;
      Ext_string.for_all (function '_' -> true | _ -> false)
        "___-" =~ false;
      Ext_string.for_all (function '_' -> true | _ -> false)        
        "" =~ true
    end;
    __LOC__ >:: begin fun _ -> 
      Ext_string.tail_from "ghsogh" 1 =~ "hsogh";
      Ext_string.tail_from "ghsogh" 0 =~ "ghsogh"
    end;
    __LOC__ >:: begin fun _ -> 
      Ext_string.digits_of_str "11_js" ~offset:0 2 =~ 11 
    end;
    __LOC__ >:: begin fun _ -> 
      OUnit.assert_bool __LOC__ 
        (Ext_string.replace_backward_slash "a:\\b\\d" = 
         "a:/b/d"
        ) ;
      OUnit.assert_bool __LOC__ 
        (Ext_string.replace_backward_slash "a:\\b\\d\\" = 
         "a:/b/d/"
        ) ;
      OUnit.assert_bool __LOC__ 
        (Ext_string.replace_slash_backward "a:/b/d/"= 
         "a:\\b\\d\\" 
        ) ;  
      OUnit.assert_bool __LOC__ 
        (let old = "a:bd" in 
         Ext_string.replace_backward_slash old == 
         old
        ) ;
      OUnit.assert_bool __LOC__ 
        (let old = "a:bd" in 
         Ext_string.replace_backward_slash old == 
         old
        ) ;

    end;
    __LOC__ >:: begin fun _ -> 
      OUnit.assert_bool __LOC__ 
        (Ext_string.no_slash "ahgoh" );
      OUnit.assert_bool __LOC__ 
        (Ext_string.no_slash "" );            
      OUnit.assert_bool __LOC__ 
        (not (Ext_string.no_slash "ahgoh/" ));
      OUnit.assert_bool __LOC__ 
        (not (Ext_string.no_slash "/ahgoh" ));
      OUnit.assert_bool __LOC__ 
        (not (Ext_string.no_slash "/ahgoh/" ));            
    end;
    __LOC__ >:: begin fun _ -> 
      let xx = "xxx" in 
      let yy = "yy" in 
      let z = (xx ^ yy) in 
      let zz = (xx ^ yy ^ yy) in 
      Ounit_tests_util.time ~nums:1000_0000 "fast length compare" begin fun _ -> 
        Bs_hash_stubs.string_length_based_compare z zz
      end;
      Ounit_tests_util.time ~nums:1000_0000 "slow length compare" begin fun _ -> 
        Ext_string.compare z zz
      end
    end
  ]