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

(declare-sort var3506 0)
(declare-sort var1392 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getHost0/1648687943 (var3506) String)
(declare-const null-var3506 var3506)
(declare-const null-String String)
(declare-const var1080 var3506) ; Statement: r0 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpRequest 
(assert (not (= var1080 null-var3506)))
(assert true)
(define-const var130 String (getHost0/1648687943 var1080)) ; Statement: r1 = specialinvoke r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: java.lang.String getHost0()>() 
 ; Statement: if r1 != null goto $r7 = r1 
(assert (not (= var130 null-String))) ; Cond: r1 != null 
(define-const var724 String var130) ; Statement: $r7 = r1 
(assert true) ; Non Conditional
 ; Statement: return $r7 
(check-sat)
; {getHost0/1648687943=([org.apache.dubbo.remoting.http12.message.DefaultHttpRequest], java.lang.String)}
; {var3506=org.apache.dubbo.remoting.http12.message.DefaultHttpRequest, var1080=r0, var130=r1, var1392=null_type, var724=$r7}
; {org.apache.dubbo.remoting.http12.message.DefaultHttpRequest=var3506, r0=var1080, r1=var130, null_type=var1392, $r7=var724}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpRequest;	r1 = specialinvoke r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: java.lang.String getHost0()>();	if r1 != null goto $r7 = r1;	$r7 = r1;	return $r7
;block_num 3