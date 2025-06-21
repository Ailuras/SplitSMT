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

(declare-sort var3487 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun charAt/698050440 ((s String) (index Int)) Int (str.to_code (str.at s index)))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-String String)
(declare-const var79 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var79 null-String)))
(assert true)
(define-const var2866 Int (length/-134980193 var79)) ; Statement: $i0 = virtualinvoke r0.<java.lang.String: int length()>() 
 ; Statement: lookupswitch($i0) {     case 1: goto $c6 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0);     case 2: goto $c3 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0);     case 6: goto $z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("\\u");     default: goto $z1 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("\\u{"); } 
(assert (and (= var2866 1) true)) ; Intersect: Cond: $i0 == 1  and Non Conditional 
(assert (not (and true (and (> (str.len var79) 0) (<= 0 0)))))
(check-sat)
; {length/-134980193=([java.lang.String], int), charAt/698050440=([java.lang.String, int], char), cast-from-Int-to-Int=([char], int)}
; {var79=r0, var3487=null_type, var2866=$i0, var1131=$c6, var18=$i11}
; {r0=var79, null_type=var3487, $i0=var2866, $c6=var1131, $i11=var18}
;seq <java.lang.String: int length()>;	<java.lang.String: char charAt(int)>
;cnt {"<java.lang.String: int length()>": 1,"<java.lang.String: char charAt(int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$i0 = virtualinvoke r0.<java.lang.String: int length()>();	lookupswitch($i0) {     case 1: goto $c6 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0);     case 2: goto $c3 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0);     case 6: goto $z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("\\u");     default: goto $z1 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("\\u{"); };	$c6 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0);	$i11 = (int) $c6;	return $i11
;block_num 2