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

(declare-sort var3458 0)
(declare-sort var987 0)
(declare-sort var3770 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun mediaType/1527701699 (var3458) var3770)
(declare-fun getName/761802846 (var3770) String)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-const null-var3458 var3458)
(declare-const null-String String)
(declare-const var2898 var3458) ; Statement: r1 := @this: org.apache.dubbo.remoting.http12.message.codec.JsonCodecFactory 
(assert (not (= var2898 null-var3458)))
(declare-const var2516 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2516 null-String)))
(assert true)
(define-const var1640 var3770 (mediaType/1527701699 var2898)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.remoting.http12.message.codec.JsonCodecFactory: org.apache.dubbo.remoting.http12.message.MediaType mediaType()>() 
(assert true)
(define-const var1308 String (getName/761802846 var1640)) ; Statement: $r3 = virtualinvoke $r2.<org.apache.dubbo.remoting.http12.message.MediaType: java.lang.String getName()>() 
(assert true)
(define-const var1930 Bool (startsWith/-1785782452 var2516 var1308)) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>($r3) 
 ; Statement: if $z0 != 0 goto $z2 = 1 
(assert (not (= (ite var1930 1 0) 0))) ; Cond: $z0 != 0 
(define-const var3602 Bool (ite (= 1 1) true false)) ; Statement: $z2 = 1 
 ; Statement: goto [?= return $z2] 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {mediaType/1527701699=([org.apache.dubbo.remoting.http12.message.codec.JsonCodecFactory], org.apache.dubbo.remoting.http12.message.MediaType), getName/761802846=([org.apache.dubbo.remoting.http12.message.MediaType], java.lang.String), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean)}
; {var3458=org.apache.dubbo.remoting.http12.message.codec.JsonCodecFactory, var2898=r1, var2516=r0, var987=null_type, var3770=org.apache.dubbo.remoting.http12.message.MediaType, var1640=$r2, var1308=$r3, var1930=$z0, var3602=$z2}
; {org.apache.dubbo.remoting.http12.message.codec.JsonCodecFactory=var3458, r1=var2898, r0=var2516, null_type=var987, org.apache.dubbo.remoting.http12.message.MediaType=var3770, $r2=var1640, $r3=var1308, $z0=var1930, $z2=var3602}
;seq <java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.http12.message.codec.JsonCodecFactory;	r0 := @parameter0: java.lang.String;	$r2 = virtualinvoke r1.<org.apache.dubbo.remoting.http12.message.codec.JsonCodecFactory: org.apache.dubbo.remoting.http12.message.MediaType mediaType()>();	$r3 = virtualinvoke $r2.<org.apache.dubbo.remoting.http12.message.MediaType: java.lang.String getName()>();	$z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>($r3);	if $z0 != 0 goto $z2 = 1;	$z2 = 1;	goto [?= return $z2];	return $z2
;block_num 3