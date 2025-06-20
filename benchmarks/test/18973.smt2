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
(declare-fun getLength-Arr-Float64-1 ((Array Int Float64)) Int)
(declare-const null-String String)
(declare-const null-__Array__Int__Float64__ (Array Int Float64))
(declare-const var1916 String) ; Statement: r0 := @parameter0: java.lang.StringBuffer 
(assert (not (= var1916 null-String)))
(declare-const var2394 (Array Int Float64)) ; Statement: r1 := @parameter1: double[] 
(assert (not (= var2394 null-__Array__Int__Float64__)))
(assert true)
;(assert (append/1183289509 var1916 91)) ; Statement: virtualinvoke r0.<java.lang.StringBuffer: java.lang.StringBuffer append(char)>(91) 

(declare-const var1916!1 String)
(declare-const var1070 Int)
(define-const var1322 Int (getLength-Arr-Float64-1 var2394)) ; Statement: i0 = lengthof r1 
(define-const var3484 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
 ; Statement: if i2 >= i0 goto virtualinvoke r0.<java.lang.StringBuffer: java.lang.StringBuffer append(char)>(93) 
(assert (>= var3484 var1322)) ; Cond: i2 >= i0 
(assert true)
;(assert (append/1183289509 var1916!1 93)) ; Statement: virtualinvoke r0.<java.lang.StringBuffer: java.lang.StringBuffer append(char)>(93) 

(declare-const var1916!2 String)
(declare-const var3279 Int)
 ; Statement: return 
(check-sat)
; {append/1183289509=([java.lang.StringBuffer, char], java.lang.StringBuffer), getLength-Arr-Float64-1=([double[]], int)}
; {var1916=r0, var2394=r1, var1070=91, var1322=i0, var3484=i2, var3279=93}
; {r0=var1916, r1=var2394, 91=var1070, i0=var1322, i2=var3484, 93=var3279}
;seq <java.lang.StringBuffer: java.lang.StringBuffer append(char)>;	<java.lang.StringBuffer: java.lang.StringBuffer append(char)>
;cnt {"<java.lang.StringBuffer: java.lang.StringBuffer append(char)>": 2}
;stmts r0 := @parameter0: java.lang.StringBuffer;	r1 := @parameter1: double[];	virtualinvoke r0.<java.lang.StringBuffer: java.lang.StringBuffer append(char)>(91);	i0 = lengthof r1;	i2 = 0;	if i2 >= i0 goto virtualinvoke r0.<java.lang.StringBuffer: java.lang.StringBuffer append(char)>(93);	virtualinvoke r0.<java.lang.StringBuffer: java.lang.StringBuffer append(char)>(93);	return
;block_num 3