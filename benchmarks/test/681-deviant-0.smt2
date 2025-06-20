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

(declare-sort var3705 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun charAt/698050440 ((s String) (index Int)) Int (str.to_code (str.at s index)))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-String String)
(declare-const var682 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var682 null-String)))
(assert true)
(define-const var3769 Int (length/-134980193 var682)) ; Statement: $i0 = virtualinvoke r0.<java.lang.String: int length()>() 
 ; Statement: lookupswitch($i0) {     case 1: goto $c6 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0);     case 2: goto $c3 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0);     case 6: goto $z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("\\u");     default: goto $z1 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("\\u{"); } 
(assert (and (= var3769 2) (and (not (= var3769 1)) true))) ; Intersect: Cond: $i0 == 2  and Intersect: Negate: Cond: $i0 == 1   and Non Conditional  
(assert (not (and true (and (> (str.len var682) 0) (<= 0 0)))))
(check-sat)
; {length/-134980193=([java.lang.String], int), charAt/698050440=([java.lang.String, int], char), cast-from-Int-to-Int=([char], int)}
; {var682=r0, var3705=null_type, var3769=$i0, var3220=$c3, var878=$i12, var2808=$i14}
; {r0=var682, null_type=var3705, $i0=var3769, $c3=var3220, $i12=var878, $i14=var2808}
;seq <java.lang.String: int length()>;	<java.lang.String: char charAt(int)>
;cnt {"<java.lang.String: int length()>": 1,"<java.lang.String: char charAt(int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$i0 = virtualinvoke r0.<java.lang.String: int length()>();	lookupswitch($i0) {     case 1: goto $c6 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0);     case 2: goto $c3 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0);     case 6: goto $z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("\\u");     default: goto $z1 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("\\u{"); };	$c3 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0);	$i12 = (int) $c3;	if $i12 == 92 goto c4 = virtualinvoke r0.<java.lang.String: char charAt(int)>(1);	$i14 = (int) -1;	return $i14
;block_num 3