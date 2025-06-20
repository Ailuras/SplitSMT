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

(declare-sort var3471 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun charAt/698050440 ((s String) (index Int)) Int (str.to_code (str.at s index)))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-String String)
(declare-const var3597 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3597 null-String)))
(assert true)
(define-const var2473 Int (length/-134980193 var3597)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int length()>() 
(define-const var1203 Int (- var2473 1)) ; Statement: $i1 = i0 - 1 
(assert (not (and true (and (> (str.len var3597) var1203) (<= 0 var1203)))))
(check-sat)
; {length/-134980193=([java.lang.String], int), charAt/698050440=([java.lang.String, int], char), cast-from-Int-to-Int=([char], int)}
; {var3597=r0, var3471=null_type, var2473=i0, var1203=$i1, var3447=$c2, var573=$i6}
; {r0=var3597, null_type=var3471, i0=var2473, $i1=var1203, $c2=var3447, $i6=var573}
;seq <java.lang.String: int length()>;	<java.lang.String: char charAt(int)>
;cnt {"<java.lang.String: int length()>": 1,"<java.lang.String: char charAt(int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	i0 = virtualinvoke r0.<java.lang.String: int length()>();	$i1 = i0 - 1;	$c2 = virtualinvoke r0.<java.lang.String: char charAt(int)>($i1);	$i6 = (int) $c2;	if $i6 != 93 goto return null;	return null
;block_num 2