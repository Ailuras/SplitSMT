(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var1652 0)
(declare-sort var2979 0)
(declare-sort var2549 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-fun var2549_invalid/-1863749183 (Int Int) var2979)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var3136 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3136 null-String)))
(declare-const var1193 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var1193 null-Int)))
(define-const var1722 Int (+ var1193 2)) ; Statement: $i2 = i0 + 2 
(assert true)
(define-const var1321 Int (length/-134980193 var3136)) ; Statement: $i1 = virtualinvoke r0.<java.lang.String: int length()>() 
 ; Statement: if $i2 > $i1 goto $i3 = virtualinvoke r0.<java.lang.String: int length()>() 
(assert (> var1722 var1321)) ; Cond: $i2 > $i1 
(assert true)
(define-const var1649 Int (length/-134980193 var3136)) ; Statement: $i3 = virtualinvoke r0.<java.lang.String: int length()>() 
(define-const var2780 Int (- var1649 1)) ; Statement: $i4 = $i3 - 1 
(define-const var865 var2979 (var2549_invalid/-1863749183 var1193 var2780)) ; Statement: $r1 = staticinvoke <org.antlr.v4.misc.EscapeSequenceParsing: org.antlr.v4.misc.EscapeSequenceParsing$Result invalid(int,int)>(i0, $i4) 
 ; Statement: return $r1 
(check-sat)
; {length/-134980193=([java.lang.String], int), var2549_invalid/-1863749183=([int, int], org.antlr.v4.misc.EscapeSequenceParsing$Result)}
; {var3136=r0, var1652=null_type, var1193=i0, var1722=$i2, var1321=$i1, var1649=$i3, var2780=$i4, var2979=org.antlr.v4.misc.EscapeSequenceParsing$Result, var2549=org.antlr.v4.misc.EscapeSequenceParsing, var865=$r1}
; {r0=var3136, null_type=var1652, i0=var1193, $i2=var1722, $i1=var1321, $i3=var1649, $i4=var2780, org.antlr.v4.misc.EscapeSequenceParsing$Result=var2979, org.antlr.v4.misc.EscapeSequenceParsing=var2549, $r1=var865}
;seq <java.lang.String: int length()>;	<java.lang.String: int length()>
;cnt {"<java.lang.String: int length()>": 2}
;stmts r0 := @parameter0: java.lang.String;	i0 := @parameter1: int;	$i2 = i0 + 2;	$i1 = virtualinvoke r0.<java.lang.String: int length()>();	if $i2 > $i1 goto $i3 = virtualinvoke r0.<java.lang.String: int length()>();	$i3 = virtualinvoke r0.<java.lang.String: int length()>();	$i4 = $i3 - 1;	$r1 = staticinvoke <org.antlr.v4.misc.EscapeSequenceParsing: org.antlr.v4.misc.EscapeSequenceParsing$Result invalid(int,int)>(i0, $i4);	return $r1
;block_num 2