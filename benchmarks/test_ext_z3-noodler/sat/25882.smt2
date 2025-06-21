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

(declare-sort var1129 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun charAt/698050440 ((s String) (index Int)) Int (str.to_code (str.at s index)))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-String String)
(declare-const var1821 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1821 null-String)))
(define-const var2049 Int 0) ; Statement: i2 = 0 
(assert true)
(define-const var3991 Int (length/-134980193 var1821)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int length()>() 
(assert true) ; Non Conditional
 ; Statement: if i2 >= i0 goto return r0 
(assert (not (>= var2049 var3991))) ; Negate: Cond: i2 >= i0  
(assert (and true (and (> (str.len var1821) var2049) (<= 0 var2049))))
(define-const var443 Int (charAt/698050440 var1821 var2049)) ; Statement: $c1 = virtualinvoke r0.<java.lang.String: char charAt(int)>(i2) 
(define-const var379 Int (cast-from-Int-to-Int var443)) ; Statement: $i3 = (int) $c1 
 ; Statement: lookupswitch($i3) {     case 36: goto $r6 = new java.lang.StringBuilder;     case 40: goto $r6 = new java.lang.StringBuilder;     case 41: goto $r6 = new java.lang.StringBuilder;     case 46: goto $r6 = new java.lang.StringBuilder;     case 91: goto $r6 = new java.lang.StringBuilder;     case 92: goto $r6 = new java.lang.StringBuilder;     case 93: goto $r6 = new java.lang.StringBuilder;     case 94: goto $r6 = new java.lang.StringBuilder;     case 123: goto $r6 = new java.lang.StringBuilder;     case 124: goto $r6 = new java.lang.StringBuilder;     case 125: goto $r6 = new java.lang.StringBuilder;     default: goto i2 = i2 + 1; } 
(assert (and (not (= var379 125)) (and (not (= var379 124)) (and (not (= var379 123)) (and (not (= var379 94)) (and (not (= var379 93)) (and (not (= var379 92)) (and (not (= var379 91)) (and (not (= var379 46)) (and (not (= var379 41)) (and (not (= var379 40)) (and (not (= var379 36)) true)))))))))))) ; Intersect: Negate: Cond: $i3 == 125   and Intersect: Negate: Cond: $i3 == 124   and Intersect: Negate: Cond: $i3 == 123   and Intersect: Negate: Cond: $i3 == 94   and Intersect: Negate: Cond: $i3 == 93   and Intersect: Negate: Cond: $i3 == 92   and Intersect: Negate: Cond: $i3 == 91   and Intersect: Negate: Cond: $i3 == 46   and Intersect: Negate: Cond: $i3 == 41   and Intersect: Negate: Cond: $i3 == 40   and Intersect: Negate: Cond: $i3 == 36   and Non Conditional           
(define-const var2049!1 Int (+ var2049 1)) ; Statement: i2 = i2 + 1 
 ; Statement: goto [?= (branch)] 
(assert true) ; Non Conditional
 ; Statement: if i2 >= i0 goto return r0 
(assert (>= var2049!1 var3991)) ; Cond: i2 >= i0 
 ; Statement: return r0 
(check-sat)
; {length/-134980193=([java.lang.String], int), charAt/698050440=([java.lang.String, int], char), cast-from-Int-to-Int=([char], int)}
; {var1821=r0, var1129=null_type, var2049=i2, var3991=i0, var443=$c1, var379=$i3}
; {r0=var1821, null_type=var1129, i2=var2049, i0=var3991, $c1=var443, $i3=var379}
;seq <java.lang.String: int length()>;	<java.lang.String: char charAt(int)>
;cnt {"<java.lang.String: int length()>": 1,"<java.lang.String: char charAt(int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	i2 = 0;	i0 = virtualinvoke r0.<java.lang.String: int length()>();	if i2 >= i0 goto return r0;	$c1 = virtualinvoke r0.<java.lang.String: char charAt(int)>(i2);	$i3 = (int) $c1;	lookupswitch($i3) {     case 36: goto $r6 = new java.lang.StringBuilder;     case 40: goto $r6 = new java.lang.StringBuilder;     case 41: goto $r6 = new java.lang.StringBuilder;     case 46: goto $r6 = new java.lang.StringBuilder;     case 91: goto $r6 = new java.lang.StringBuilder;     case 92: goto $r6 = new java.lang.StringBuilder;     case 93: goto $r6 = new java.lang.StringBuilder;     case 94: goto $r6 = new java.lang.StringBuilder;     case 123: goto $r6 = new java.lang.StringBuilder;     case 124: goto $r6 = new java.lang.StringBuilder;     case 125: goto $r6 = new java.lang.StringBuilder;     default: goto i2 = i2 + 1; };	i2 = i2 + 1;	goto [?= (branch)];	if i2 >= i0 goto return r0;	return r0
;block_num 6