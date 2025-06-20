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
(declare-fun getLength-Arr-Float32-1 ((Array Int Float32)) Int)
(declare-const null-String String)
(declare-const null-__Array__Int__Float32__ (Array Int Float32))
(declare-const var3872 String) ; Statement: r0 := @parameter0: java.lang.StringBuilder 
(assert (not (= var3872 null-String)))
(declare-const var3893 (Array Int Float32)) ; Statement: r1 := @parameter1: float[] 
(assert (not (= var3893 null-__Array__Int__Float32__)))
(assert true)
;(assert (append/-1166366385 var3872 91)) ; Statement: virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(91) 
(declare-const var3872!1 String)
(assert (str.prefixof var3872 var3872!1))
(define-const var3489 Int (getLength-Arr-Float32-1 var3893)) ; Statement: i0 = lengthof r1 
(define-const var2167 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
 ; Statement: if i2 >= i0 goto virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(93) 
(assert (>= var2167 var3489)) ; Cond: i2 >= i0 
(assert true)
;(assert (append/-1166366385 var3872!1 93)) ; Statement: virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(93) 
(declare-const var3872!2 String)
(assert (str.prefixof var3872!1 var3872!2))
 ; Statement: return 
(check-sat)
; {append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), getLength-Arr-Float32-1=([float[]], int)}
; {var3872=r0, var3893=r1, var3489=i0, var2167=i2}
; {r0=var3872, r1=var3893, i0=var3489, i2=var2167}
;seq <java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>
;cnt {"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 2}
;stmts r0 := @parameter0: java.lang.StringBuilder;	r1 := @parameter1: float[];	virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(91);	i0 = lengthof r1;	i2 = 0;	if i2 >= i0 goto virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(93);	virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(93);	return
;block_num 3