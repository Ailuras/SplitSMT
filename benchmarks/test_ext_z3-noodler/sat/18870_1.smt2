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
(declare-fun getLength-Arr-Int-1 ((Array Int Int)) Int)
(declare-const null-String String)
(declare-const null-__Array__Int__Int__ (Array Int Int))
(declare-const var1188 String) ; Statement: r0 := @parameter0: java.lang.StringBuffer 
(assert (not (= var1188 null-String)))
(declare-const var1795 (Array Int Int)) ; Statement: r1 := @parameter1: long[] 
(assert (not (= var1795 null-__Array__Int__Int__)))
(assert true)
;(assert (append/1183289509 var1188 91)) ; Statement: virtualinvoke r0.<java.lang.StringBuffer: java.lang.StringBuffer append(char)>(91) 

(declare-const var1188!1 String)
(declare-const var184 Int)
(define-const var425 Int (getLength-Arr-Int-1 var1795)) ; Statement: i0 = lengthof r1 
(define-const var2880 Int 0) ; Statement: i3 = 0 
(assert true) ; Non Conditional
 ; Statement: if i3 >= i0 goto virtualinvoke r0.<java.lang.StringBuffer: java.lang.StringBuffer append(char)>(93) 
(assert (>= var2880 var425)) ; Cond: i3 >= i0 
(assert true)
;(assert (append/1183289509 var1188!1 93)) ; Statement: virtualinvoke r0.<java.lang.StringBuffer: java.lang.StringBuffer append(char)>(93) 

(declare-const var1188!2 String)
(declare-const var3304 Int)
 ; Statement: return 
(check-sat)
; {append/1183289509=([java.lang.StringBuffer, char], java.lang.StringBuffer), getLength-Arr-Int-1=([long[]], int)}
; {var1188=r0, var1795=r1, var184=91, var425=i0, var2880=i3, var3304=93}
; {r0=var1188, r1=var1795, 91=var184, i0=var425, i3=var2880, 93=var3304}
;seq <java.lang.StringBuffer: java.lang.StringBuffer append(char)>;	<java.lang.StringBuffer: java.lang.StringBuffer append(char)>
;cnt {"<java.lang.StringBuffer: java.lang.StringBuffer append(char)>": 2}
;stmts r0 := @parameter0: java.lang.StringBuffer;	r1 := @parameter1: long[];	virtualinvoke r0.<java.lang.StringBuffer: java.lang.StringBuffer append(char)>(91);	i0 = lengthof r1;	i3 = 0;	if i3 >= i0 goto virtualinvoke r0.<java.lang.StringBuffer: java.lang.StringBuffer append(char)>(93);	virtualinvoke r0.<java.lang.StringBuffer: java.lang.StringBuffer append(char)>(93);	return
;block_num 3