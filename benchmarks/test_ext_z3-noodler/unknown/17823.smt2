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

(declare-sort var1353 0)
(declare-sort var3789 0)
(declare-sort var1968 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun mediaType/2121095857 (var1353) var1968)
(declare-fun getName/761802846 (var1968) String)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-const null-var1353 var1353)
(declare-const null-String String)
(declare-const var2348 var1353) ; Statement: r1 := @this: org.apache.dubbo.remoting.http12.message.codec.JsonPbCodecFactory 
(assert (not (= var2348 null-var1353)))
(declare-const var1519 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1519 null-String)))
(assert true)
(define-const var638 var1968 (mediaType/2121095857 var2348)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.remoting.http12.message.codec.JsonPbCodecFactory: org.apache.dubbo.remoting.http12.message.MediaType mediaType()>() 
(assert true)
(define-const var2358 String (getName/761802846 var638)) ; Statement: $r3 = virtualinvoke $r2.<org.apache.dubbo.remoting.http12.message.MediaType: java.lang.String getName()>() 
(assert true)
(define-const var2795 Bool (startsWith/-1785782452 var1519 var2358)) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>($r3) 
 ; Statement: if $z0 != 0 goto $z2 = 1 
(assert (not (= (ite var2795 1 0) 0))) ; Cond: $z0 != 0 
(define-const var1694 Bool (ite (= 1 1) true false)) ; Statement: $z2 = 1 
 ; Statement: goto [?= return $z2] 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {mediaType/2121095857=([org.apache.dubbo.remoting.http12.message.codec.JsonPbCodecFactory], org.apache.dubbo.remoting.http12.message.MediaType), getName/761802846=([org.apache.dubbo.remoting.http12.message.MediaType], java.lang.String), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean)}
; {var1353=org.apache.dubbo.remoting.http12.message.codec.JsonPbCodecFactory, var2348=r1, var1519=r0, var3789=null_type, var1968=org.apache.dubbo.remoting.http12.message.MediaType, var638=$r2, var2358=$r3, var2795=$z0, var1694=$z2}
; {org.apache.dubbo.remoting.http12.message.codec.JsonPbCodecFactory=var1353, r1=var2348, r0=var1519, null_type=var3789, org.apache.dubbo.remoting.http12.message.MediaType=var1968, $r2=var638, $r3=var2358, $z0=var2795, $z2=var1694}
;seq <java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.http12.message.codec.JsonPbCodecFactory;	r0 := @parameter0: java.lang.String;	$r2 = virtualinvoke r1.<org.apache.dubbo.remoting.http12.message.codec.JsonPbCodecFactory: org.apache.dubbo.remoting.http12.message.MediaType mediaType()>();	$r3 = virtualinvoke $r2.<org.apache.dubbo.remoting.http12.message.MediaType: java.lang.String getName()>();	$z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>($r3);	if $z0 != 0 goto $z2 = 1;	$z2 = 1;	goto [?= return $z2];	return $z2
;block_num 3