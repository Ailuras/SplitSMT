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

(declare-sort var2743 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-String String)
(declare-const var775 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var775 null-String)))
(assert true)
(define-const var1364 Int (length/-134980193 var775)) ; Statement: $i0 = virtualinvoke r0.<java.lang.String: int length()>() 
 ; Statement: lookupswitch($i0) {     case 1: goto $c6 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0);     case 2: goto $c3 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0);     case 6: goto $z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("\\u");     default: goto $z1 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("\\u{"); } 
(assert (and (= var1364 6) (and (not (= var1364 2)) (and (not (= var1364 1)) true)))) ; Intersect: Cond: $i0 == 6  and Intersect: Negate: Cond: $i0 == 2   and Intersect: Negate: Cond: $i0 == 1   and Non Conditional   
(assert true)
(define-const var3435 Bool (startsWith/-1785782452 var775 "\u005cu")) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("\\u") 
 ; Statement: if $z0 != 0 goto $c1 = virtualinvoke r0.<java.lang.String: char charAt(int)>(2) 
(assert (not (not (= (ite var3435 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var2435 Int (cast-from-Int-to-Int -1)) ; Statement: $i21 = (int) -1 
 ; Statement: return $i21 
(check-sat)
; {length/-134980193=([java.lang.String], int), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean), cast-from-Int-to-Int=([int], int)}
; {var775=r0, var2743=null_type, var1364=$i0, var3435=$z0, var2435=$i21}
; {r0=var775, null_type=var2743, $i0=var1364, $z0=var3435, $i21=var2435}
;seq <java.lang.String: int length()>;	<java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: int length()>": 1,"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$i0 = virtualinvoke r0.<java.lang.String: int length()>();	lookupswitch($i0) {     case 1: goto $c6 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0);     case 2: goto $c3 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0);     case 6: goto $z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("\\u");     default: goto $z1 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("\\u{"); };	$z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("\\u");	if $z0 != 0 goto $c1 = virtualinvoke r0.<java.lang.String: char charAt(int)>(2);	$i21 = (int) -1;	return $i21
;block_num 3