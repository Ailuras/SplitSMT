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

(declare-sort var1344 0)
(declare-sort var2063 0)
(declare-sort var2888 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun mediaType/-89266150 (var1344) var2888)
(declare-fun getName/761802846 (var2888) String)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-const null-var1344 var1344)
(declare-const null-String String)
(declare-const var2380 var1344) ; Statement: r1 := @this: org.apache.dubbo.remoting.http12.message.codec.XmlCodecFactory 
(assert (not (= var2380 null-var1344)))
(declare-const var2765 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2765 null-String)))
(assert true)
(define-const var3033 var2888 (mediaType/-89266150 var2380)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.remoting.http12.message.codec.XmlCodecFactory: org.apache.dubbo.remoting.http12.message.MediaType mediaType()>() 
(assert true)
(define-const var61 String (getName/761802846 var3033)) ; Statement: $r3 = virtualinvoke $r2.<org.apache.dubbo.remoting.http12.message.MediaType: java.lang.String getName()>() 
(assert true)
(define-const var657 Bool (startsWith/-1785782452 var2765 var61)) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>($r3) 
 ; Statement: if $z0 != 0 goto $z2 = 1 
(assert (not (= (ite var657 1 0) 0))) ; Cond: $z0 != 0 
(define-const var2715 Bool (ite (= 1 1) true false)) ; Statement: $z2 = 1 
 ; Statement: goto [?= return $z2] 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {mediaType/-89266150=([org.apache.dubbo.remoting.http12.message.codec.XmlCodecFactory], org.apache.dubbo.remoting.http12.message.MediaType), getName/761802846=([org.apache.dubbo.remoting.http12.message.MediaType], java.lang.String), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean)}
; {var1344=org.apache.dubbo.remoting.http12.message.codec.XmlCodecFactory, var2380=r1, var2765=r0, var2063=null_type, var2888=org.apache.dubbo.remoting.http12.message.MediaType, var3033=$r2, var61=$r3, var657=$z0, var2715=$z2}
; {org.apache.dubbo.remoting.http12.message.codec.XmlCodecFactory=var1344, r1=var2380, r0=var2765, null_type=var2063, org.apache.dubbo.remoting.http12.message.MediaType=var2888, $r2=var3033, $r3=var61, $z0=var657, $z2=var2715}
;seq <java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.http12.message.codec.XmlCodecFactory;	r0 := @parameter0: java.lang.String;	$r2 = virtualinvoke r1.<org.apache.dubbo.remoting.http12.message.codec.XmlCodecFactory: org.apache.dubbo.remoting.http12.message.MediaType mediaType()>();	$r3 = virtualinvoke $r2.<org.apache.dubbo.remoting.http12.message.MediaType: java.lang.String getName()>();	$z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>($r3);	if $z0 != 0 goto $z2 = 1;	$z2 = 1;	goto [?= return $z2];	return $z2
;block_num 3