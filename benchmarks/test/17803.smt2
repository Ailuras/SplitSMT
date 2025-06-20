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

(declare-sort var569 0)
(declare-sort var1410 0)
(declare-sort var3727 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun mediaType/-89266150 (var569) var3727)
(declare-fun getName/761802846 (var3727) String)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-const null-var569 var569)
(declare-const null-String String)
(declare-const var3727-TEXT_XML var3727)
(declare-const var694 var569) ; Statement: r1 := @this: org.apache.dubbo.remoting.http12.message.codec.XmlCodecFactory 
(assert (not (= var694 null-var569)))
(declare-const var219 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var219 null-String)))
(assert true)
(define-const var698 var3727 (mediaType/-89266150 var694)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.remoting.http12.message.codec.XmlCodecFactory: org.apache.dubbo.remoting.http12.message.MediaType mediaType()>() 
(assert true)
(define-const var473 String (getName/761802846 var698)) ; Statement: $r3 = virtualinvoke $r2.<org.apache.dubbo.remoting.http12.message.MediaType: java.lang.String getName()>() 
(assert true)
(define-const var2184 Bool (startsWith/-1785782452 var219 var473)) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>($r3) 
 ; Statement: if $z0 != 0 goto $z2 = 1 
(assert (not (not (= (ite var2184 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var1499 var3727 var3727-TEXT_XML) ; Statement: $r4 = <org.apache.dubbo.remoting.http12.message.MediaType: org.apache.dubbo.remoting.http12.message.MediaType TEXT_XML> 
(assert true)
(define-const var374 String (getName/761802846 var1499)) ; Statement: $r5 = virtualinvoke $r4.<org.apache.dubbo.remoting.http12.message.MediaType: java.lang.String getName()>() 
(assert true)
(define-const var2918 Bool (startsWith/-1785782452 var219 var374)) ; Statement: $z1 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>($r5) 
 ; Statement: if $z1 == 0 goto $z2 = 0 
(assert (not (= (ite var2918 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var1785 Bool (ite (= 1 1) true false)) ; Statement: $z2 = 1 
 ; Statement: goto [?= return $z2] 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {mediaType/-89266150=([org.apache.dubbo.remoting.http12.message.codec.XmlCodecFactory], org.apache.dubbo.remoting.http12.message.MediaType), getName/761802846=([org.apache.dubbo.remoting.http12.message.MediaType], java.lang.String), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean)}
; {var569=org.apache.dubbo.remoting.http12.message.codec.XmlCodecFactory, var694=r1, var219=r0, var1410=null_type, var3727=org.apache.dubbo.remoting.http12.message.MediaType, var698=$r2, var473=$r3, var2184=$z0, var1499=$r4, var374=$r5, var2918=$z1, var1785=$z2}
; {org.apache.dubbo.remoting.http12.message.codec.XmlCodecFactory=var569, r1=var694, r0=var219, null_type=var1410, org.apache.dubbo.remoting.http12.message.MediaType=var3727, $r2=var698, $r3=var473, $z0=var2184, $r4=var1499, $r5=var374, $z1=var2918, $z2=var1785}
;seq <java.lang.String: boolean startsWith(java.lang.String)>;	<java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 2}
;stmts r1 := @this: org.apache.dubbo.remoting.http12.message.codec.XmlCodecFactory;	r0 := @parameter0: java.lang.String;	$r2 = virtualinvoke r1.<org.apache.dubbo.remoting.http12.message.codec.XmlCodecFactory: org.apache.dubbo.remoting.http12.message.MediaType mediaType()>();	$r3 = virtualinvoke $r2.<org.apache.dubbo.remoting.http12.message.MediaType: java.lang.String getName()>();	$z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>($r3);	if $z0 != 0 goto $z2 = 1;	$r4 = <org.apache.dubbo.remoting.http12.message.MediaType: org.apache.dubbo.remoting.http12.message.MediaType TEXT_XML>;	$r5 = virtualinvoke $r4.<org.apache.dubbo.remoting.http12.message.MediaType: java.lang.String getName()>();	$z1 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>($r5);	if $z1 == 0 goto $z2 = 0;	$z2 = 1;	goto [?= return $z2];	return $z2
;block_num 4