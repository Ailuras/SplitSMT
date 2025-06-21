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

(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun getLength-Arr-Int-1 ((Array Int Int)) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-const null-String String)
(declare-const null-__Array__Int__Int__ (Array Int Int))
(declare-const var2579 String) ; Statement: r0 := @parameter0: java.lang.StringBuilder 
(assert (not (= var2579 null-String)))
(declare-const var2295 (Array Int Int)) ; Statement: r1 := @parameter1: int[] 
(assert (not (= var2295 null-__Array__Int__Int__)))
(assert true)
;(assert (append/-1166366385 var2579 91)) ; Statement: virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(91) 
(declare-const var2579!1 String)
(assert (str.prefixof var2579 var2579!1))
(define-const var2528 Int (getLength-Arr-Int-1 var2295)) ; Statement: i0 = lengthof r1 
(define-const var2581 Int 0) ; Statement: i3 = 0 
(assert true) ; Non Conditional
 ; Statement: if i3 >= i0 goto virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(93) 
(assert (not (>= var2581 var2528))) ; Negate: Cond: i3 >= i0  
(define-const var2743 Int (select var2295 var2581)) ; Statement: $i1 = r1[i3] 
(assert true)
;(assert (append/-1001720160 var2579!1 var2743)) ; Statement: virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i1) 
(declare-const var2579!2 String)
(assert (str.prefixof var2579!1 var2579!2))
(define-const var491 Int (- var2528 1)) ; Statement: $i2 = i0 - 1 
 ; Statement: if i3 == $i2 goto i3 = i3 + 1 
(assert (= var2581 var491)) ; Cond: i3 == $i2 
(define-const var2581!1 Int (+ var2581 1)) ; Statement: i3 = i3 + 1 
 ; Statement: goto [?= (branch)] 
(assert true) ; Non Conditional
 ; Statement: if i3 >= i0 goto virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(93) 
(assert (>= var2581!1 var2528)) ; Cond: i3 >= i0 
(assert true)
;(assert (append/-1166366385 var2579!2 93)) ; Statement: virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(93) 
(declare-const var2579!3 String)
(assert (str.prefixof var2579!2 var2579!3))
 ; Statement: return 
(check-sat)
; {append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), getLength-Arr-Int-1=([int[]], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder)}
; {var2579=r0, var2295=r1, var2528=i0, var2581=i3, var2743=$i1, var491=$i2}
; {r0=var2579, r1=var2295, i0=var2528, i3=var2581, $i1=var2743, $i2=var491}
;seq <java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>
;cnt {"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1}
;stmts r0 := @parameter0: java.lang.StringBuilder;	r1 := @parameter1: int[];	virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(91);	i0 = lengthof r1;	i3 = 0;	if i3 >= i0 goto virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(93);	$i1 = r1[i3];	virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i1);	$i2 = i0 - 1;	if i3 == $i2 goto i3 = i3 + 1;	i3 = i3 + 1;	goto [?= (branch)];	if i3 >= i0 goto virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(93);	virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(93);	return
;block_num 6