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

(declare-sort var1175 0)
(declare-sort var2129 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun charset/-562224243 (var1175) String)
(define-fun isEmpty/-1285796103 ((s String)) Bool (= (str.len s) 0))
(declare-const null-var1175 var1175)
(declare-const null-String String)
(declare-const var3906 var1175) ; Statement: r0 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpRequest 
(assert (not (= var3906 null-var1175)))
(define-const var2413 String (charset/-562224243 var3906)) ; Statement: r3 = r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: java.lang.String charset> 
 ; Statement: if r3 != null goto $z0 = virtualinvoke r3.<java.lang.String: boolean isEmpty()>() 
(assert (not (= var2413 null-String))) ; Cond: r3 != null 
(assert true)
(define-const var2056 Bool (isEmpty/-1285796103 var2413)) ; Statement: $z0 = virtualinvoke r3.<java.lang.String: boolean isEmpty()>() 
 ; Statement: if $z0 == 0 goto $r5 = r3 
(assert (= (ite var2056 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2333 String var2413) ; Statement: $r5 = r3 
(assert true) ; Non Conditional
 ; Statement: return $r5 
(check-sat)
; {charset/-562224243=([org.apache.dubbo.remoting.http12.message.DefaultHttpRequest], java.lang.String), isEmpty/-1285796103=([java.lang.String], boolean)}
; {var1175=org.apache.dubbo.remoting.http12.message.DefaultHttpRequest, var3906=r0, var2413=r3, var2129=null_type, var2056=$z0, var2333=$r5}
; {org.apache.dubbo.remoting.http12.message.DefaultHttpRequest=var1175, r0=var3906, r3=var2413, null_type=var2129, $z0=var2056, $r5=var2333}
;seq <java.lang.String: boolean isEmpty()>
;cnt {"<java.lang.String: boolean isEmpty()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpRequest;	r3 = r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: java.lang.String charset>;	if r3 != null goto $z0 = virtualinvoke r3.<java.lang.String: boolean isEmpty()>();	$z0 = virtualinvoke r3.<java.lang.String: boolean isEmpty()>();	if $z0 == 0 goto $r5 = r3;	$r5 = r3;	return $r5
;block_num 4