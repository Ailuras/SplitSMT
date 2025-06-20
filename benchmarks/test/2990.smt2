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
(declare-fun getLength-Arr-Bool-1 ((Array Int Bool)) Int)
(declare-const null-String String)
(declare-const null-__Array__Int__Bool__ (Array Int Bool))
(declare-const var1456 String) ; Statement: r0 := @parameter0: java.lang.StringBuilder 
(assert (not (= var1456 null-String)))
(declare-const var1846 (Array Int Bool)) ; Statement: r1 := @parameter1: boolean[] 
(assert (not (= var1846 null-__Array__Int__Bool__)))
(assert true)
;(assert (append/-1166366385 var1456 91)) ; Statement: virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(91) 
(declare-const var1456!1 String)
(assert (str.prefixof var1456 var1456!1))
(define-const var2856 Int (getLength-Arr-Bool-1 var1846)) ; Statement: i0 = lengthof r1 
(define-const var2605 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
 ; Statement: if i2 >= i0 goto virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(93) 
(assert (>= var2605 var2856)) ; Cond: i2 >= i0 
(assert true)
;(assert (append/-1166366385 var1456!1 93)) ; Statement: virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(93) 
(declare-const var1456!2 String)
(assert (str.prefixof var1456!1 var1456!2))
 ; Statement: return 
(check-sat)
; {append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), getLength-Arr-Bool-1=([boolean[]], int)}
; {var1456=r0, var1846=r1, var2856=i0, var2605=i2}
; {r0=var1456, r1=var1846, i0=var2856, i2=var2605}
;seq <java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>
;cnt {"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 2}
;stmts r0 := @parameter0: java.lang.StringBuilder;	r1 := @parameter1: boolean[];	virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(91);	i0 = lengthof r1;	i2 = 0;	if i2 >= i0 goto virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(93);	virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(93);	return
;block_num 3