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

(declare-sort var331 0)
(declare-sort var847 0)
(declare-sort var1717 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun mediaType/-89266150 (var331) var1717)
(declare-fun getName/761802846 (var1717) String)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-const null-var331 var331)
(declare-const null-String String)
(declare-const var1717-TEXT_XML var1717)
(declare-const var3801 var331) ; Statement: r1 := @this: org.apache.dubbo.remoting.http12.message.codec.XmlCodecFactory 
(assert (not (= var3801 null-var331)))
(declare-const var117 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var117 null-String)))
(assert true)
(define-const var2670 var1717 (mediaType/-89266150 var3801)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.remoting.http12.message.codec.XmlCodecFactory: org.apache.dubbo.remoting.http12.message.MediaType mediaType()>() 
(assert true)
(define-const var132 String (getName/761802846 var2670)) ; Statement: $r3 = virtualinvoke $r2.<org.apache.dubbo.remoting.http12.message.MediaType: java.lang.String getName()>() 
(assert true)
(define-const var2387 Bool (startsWith/-1785782452 var117 var132)) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>($r3) 
 ; Statement: if $z0 != 0 goto $z2 = 1 
(assert (not (not (= (ite var2387 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var2309 var1717 var1717-TEXT_XML) ; Statement: $r4 = <org.apache.dubbo.remoting.http12.message.MediaType: org.apache.dubbo.remoting.http12.message.MediaType TEXT_XML> 
(assert true)
(define-const var3381 String (getName/761802846 var2309)) ; Statement: $r5 = virtualinvoke $r4.<org.apache.dubbo.remoting.http12.message.MediaType: java.lang.String getName()>() 
(assert true)
(define-const var2469 Bool (startsWith/-1785782452 var117 var3381)) ; Statement: $z1 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>($r5) 
 ; Statement: if $z1 == 0 goto $z2 = 0 
(assert (= (ite var2469 1 0) 0)) ; Cond: $z1 == 0 
(define-const var2605 Bool (ite (= 1 0) true false)) ; Statement: $z2 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {mediaType/-89266150=([org.apache.dubbo.remoting.http12.message.codec.XmlCodecFactory], org.apache.dubbo.remoting.http12.message.MediaType), getName/761802846=([org.apache.dubbo.remoting.http12.message.MediaType], java.lang.String), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean)}
; {var331=org.apache.dubbo.remoting.http12.message.codec.XmlCodecFactory, var3801=r1, var117=r0, var847=null_type, var1717=org.apache.dubbo.remoting.http12.message.MediaType, var2670=$r2, var132=$r3, var2387=$z0, var2309=$r4, var3381=$r5, var2469=$z1, var2605=$z2}
; {org.apache.dubbo.remoting.http12.message.codec.XmlCodecFactory=var331, r1=var3801, r0=var117, null_type=var847, org.apache.dubbo.remoting.http12.message.MediaType=var1717, $r2=var2670, $r3=var132, $z0=var2387, $r4=var2309, $r5=var3381, $z1=var2469, $z2=var2605}
;seq <java.lang.String: boolean startsWith(java.lang.String)>;	<java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 2}
;stmts r1 := @this: org.apache.dubbo.remoting.http12.message.codec.XmlCodecFactory;	r0 := @parameter0: java.lang.String;	$r2 = virtualinvoke r1.<org.apache.dubbo.remoting.http12.message.codec.XmlCodecFactory: org.apache.dubbo.remoting.http12.message.MediaType mediaType()>();	$r3 = virtualinvoke $r2.<org.apache.dubbo.remoting.http12.message.MediaType: java.lang.String getName()>();	$z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>($r3);	if $z0 != 0 goto $z2 = 1;	$r4 = <org.apache.dubbo.remoting.http12.message.MediaType: org.apache.dubbo.remoting.http12.message.MediaType TEXT_XML>;	$r5 = virtualinvoke $r4.<org.apache.dubbo.remoting.http12.message.MediaType: java.lang.String getName()>();	$z1 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>($r5);	if $z1 == 0 goto $z2 = 0;	$z2 = 0;	return $z2
;block_num 4