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
(declare-fun append/1183289509 (String Int) String)
(declare-fun getLength-Arr-Float32-1 ((Array Int Float32)) Int)
(declare-const null-String String)
(declare-const null-__Array__Int__Float32__ (Array Int Float32))
(declare-const var3322 String) ; Statement: r0 := @parameter0: java.lang.StringBuffer 
(assert (not (= var3322 null-String)))
(declare-const var874 (Array Int Float32)) ; Statement: r1 := @parameter1: float[] 
(assert (not (= var874 null-__Array__Int__Float32__)))
(assert true)
;(assert (append/1183289509 var3322 91)) ; Statement: virtualinvoke r0.<java.lang.StringBuffer: java.lang.StringBuffer append(char)>(91) 

(declare-const var3322!1 String)
(declare-const var2117 Int)
(define-const var1656 Int (getLength-Arr-Float32-1 var874)) ; Statement: i0 = lengthof r1 
(define-const var2388 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
 ; Statement: if i2 >= i0 goto virtualinvoke r0.<java.lang.StringBuffer: java.lang.StringBuffer append(char)>(93) 
(assert (>= var2388 var1656)) ; Cond: i2 >= i0 
(assert true)
;(assert (append/1183289509 var3322!1 93)) ; Statement: virtualinvoke r0.<java.lang.StringBuffer: java.lang.StringBuffer append(char)>(93) 

(declare-const var3322!2 String)
(declare-const var879 Int)
 ; Statement: return 
(check-sat)
; {append/1183289509=([java.lang.StringBuffer, char], java.lang.StringBuffer), getLength-Arr-Float32-1=([float[]], int)}
; {var3322=r0, var874=r1, var2117=91, var1656=i0, var2388=i2, var879=93}
; {r0=var3322, r1=var874, 91=var2117, i0=var1656, i2=var2388, 93=var879}
;seq <java.lang.StringBuffer: java.lang.StringBuffer append(char)>;	<java.lang.StringBuffer: java.lang.StringBuffer append(char)>
;cnt {"<java.lang.StringBuffer: java.lang.StringBuffer append(char)>": 2}
;stmts r0 := @parameter0: java.lang.StringBuffer;	r1 := @parameter1: float[];	virtualinvoke r0.<java.lang.StringBuffer: java.lang.StringBuffer append(char)>(91);	i0 = lengthof r1;	i2 = 0;	if i2 >= i0 goto virtualinvoke r0.<java.lang.StringBuffer: java.lang.StringBuffer append(char)>(93);	virtualinvoke r0.<java.lang.StringBuffer: java.lang.StringBuffer append(char)>(93);	return
;block_num 3