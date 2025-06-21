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

(declare-sort var3777 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-String String)
(declare-const var1577 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1577 null-String)))
(assert true)
(define-const var3131 Int (length/-134980193 var1577)) ; Statement: $i0 = virtualinvoke r0.<java.lang.String: int length()>() 
 ; Statement: lookupswitch($i0) {     case 1: goto $c6 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0);     case 2: goto $c3 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0);     case 6: goto $z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("\\u");     default: goto $z1 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("\\u{"); } 
(assert (and (not (= var3131 6)) (and (not (= var3131 2)) (and (not (= var3131 1)) true)))) ; Intersect: Negate: Cond: $i0 == 6   and Intersect: Negate: Cond: $i0 == 2   and Intersect: Negate: Cond: $i0 == 1   and Non Conditional   
(assert true)
(define-const var2802 Bool (startsWith/-1785782452 var1577 "\u005cu{")) ; Statement: $z1 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("\\u{") 
 ; Statement: if $z1 == 0 goto $i24 = (int) -1 
(assert (= (ite var2802 1 0) 0)) ; Cond: $z1 == 0 
(define-const var3901 Int (cast-from-Int-to-Int -1)) ; Statement: $i24 = (int) -1 
 ; Statement: return $i24 
(check-sat)
; {length/-134980193=([java.lang.String], int), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean), cast-from-Int-to-Int=([int], int)}
; {var1577=r0, var3777=null_type, var3131=$i0, var2802=$z1, var3901=$i24}
; {r0=var1577, null_type=var3777, $i0=var3131, $z1=var2802, $i24=var3901}
;seq <java.lang.String: int length()>;	<java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: int length()>": 1,"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$i0 = virtualinvoke r0.<java.lang.String: int length()>();	lookupswitch($i0) {     case 1: goto $c6 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0);     case 2: goto $c3 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0);     case 6: goto $z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("\\u");     default: goto $z1 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("\\u{"); };	$z1 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("\\u{");	if $z1 == 0 goto $i24 = (int) -1;	$i24 = (int) -1;	return $i24
;block_num 3