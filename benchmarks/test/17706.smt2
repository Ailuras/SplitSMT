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

(declare-sort var2941 0)
(declare-sort var3004 0)
(declare-sort var1612 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun mediaType/935015136 (var2941) var1612)
(declare-fun getName/761802846 (var1612) String)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-const null-var2941 var2941)
(declare-const null-String String)
(declare-const var3531 var2941) ; Statement: r1 := @this: org.apache.dubbo.remoting.http12.message.codec.HtmlCodecFactory 
(assert (not (= var3531 null-var2941)))
(declare-const var3352 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3352 null-String)))
(assert true)
(define-const var3015 var1612 (mediaType/935015136 var3531)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.remoting.http12.message.codec.HtmlCodecFactory: org.apache.dubbo.remoting.http12.message.MediaType mediaType()>() 
(assert true)
(define-const var841 String (getName/761802846 var3015)) ; Statement: $r3 = virtualinvoke $r2.<org.apache.dubbo.remoting.http12.message.MediaType: java.lang.String getName()>() 
(assert true)
(define-const var685 Bool (startsWith/-1785782452 var3352 var841)) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>($r3) 
 ; Statement: if $z0 != 0 goto $z2 = 1 
(assert (not (= (ite var685 1 0) 0))) ; Cond: $z0 != 0 
(define-const var2404 Bool (ite (= 1 1) true false)) ; Statement: $z2 = 1 
 ; Statement: goto [?= return $z2] 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {mediaType/935015136=([org.apache.dubbo.remoting.http12.message.codec.HtmlCodecFactory], org.apache.dubbo.remoting.http12.message.MediaType), getName/761802846=([org.apache.dubbo.remoting.http12.message.MediaType], java.lang.String), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean)}
; {var2941=org.apache.dubbo.remoting.http12.message.codec.HtmlCodecFactory, var3531=r1, var3352=r0, var3004=null_type, var1612=org.apache.dubbo.remoting.http12.message.MediaType, var3015=$r2, var841=$r3, var685=$z0, var2404=$z2}
; {org.apache.dubbo.remoting.http12.message.codec.HtmlCodecFactory=var2941, r1=var3531, r0=var3352, null_type=var3004, org.apache.dubbo.remoting.http12.message.MediaType=var1612, $r2=var3015, $r3=var841, $z0=var685, $z2=var2404}
;seq <java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.http12.message.codec.HtmlCodecFactory;	r0 := @parameter0: java.lang.String;	$r2 = virtualinvoke r1.<org.apache.dubbo.remoting.http12.message.codec.HtmlCodecFactory: org.apache.dubbo.remoting.http12.message.MediaType mediaType()>();	$r3 = virtualinvoke $r2.<org.apache.dubbo.remoting.http12.message.MediaType: java.lang.String getName()>();	$z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>($r3);	if $z0 != 0 goto $z2 = 1;	$z2 = 1;	goto [?= return $z2];	return $z2
;block_num 3