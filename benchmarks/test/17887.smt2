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

(declare-sort var1957 0)
(declare-sort var33 0)
(declare-sort var3250 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun mediaType/-1497802396 (var1957) var3250)
(declare-fun getName/761802846 (var3250) String)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-const null-var1957 var1957)
(declare-const null-String String)
(declare-const var3055 var1957) ; Statement: r1 := @this: org.apache.dubbo.remoting.http12.message.codec.YamlCodecFactory 
(assert (not (= var3055 null-var1957)))
(declare-const var1379 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1379 null-String)))
(assert true)
(define-const var1747 var3250 (mediaType/-1497802396 var3055)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.remoting.http12.message.codec.YamlCodecFactory: org.apache.dubbo.remoting.http12.message.MediaType mediaType()>() 
(assert true)
(define-const var784 String (getName/761802846 var1747)) ; Statement: $r3 = virtualinvoke $r2.<org.apache.dubbo.remoting.http12.message.MediaType: java.lang.String getName()>() 
(assert true)
(define-const var2238 Bool (startsWith/-1785782452 var1379 var784)) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>($r3) 
 ; Statement: if $z0 != 0 goto $z2 = 1 
(assert (not (= (ite var2238 1 0) 0))) ; Cond: $z0 != 0 
(define-const var1288 Bool (ite (= 1 1) true false)) ; Statement: $z2 = 1 
 ; Statement: goto [?= return $z2] 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {mediaType/-1497802396=([org.apache.dubbo.remoting.http12.message.codec.YamlCodecFactory], org.apache.dubbo.remoting.http12.message.MediaType), getName/761802846=([org.apache.dubbo.remoting.http12.message.MediaType], java.lang.String), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean)}
; {var1957=org.apache.dubbo.remoting.http12.message.codec.YamlCodecFactory, var3055=r1, var1379=r0, var33=null_type, var3250=org.apache.dubbo.remoting.http12.message.MediaType, var1747=$r2, var784=$r3, var2238=$z0, var1288=$z2}
; {org.apache.dubbo.remoting.http12.message.codec.YamlCodecFactory=var1957, r1=var3055, r0=var1379, null_type=var33, org.apache.dubbo.remoting.http12.message.MediaType=var3250, $r2=var1747, $r3=var784, $z0=var2238, $z2=var1288}
;seq <java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.http12.message.codec.YamlCodecFactory;	r0 := @parameter0: java.lang.String;	$r2 = virtualinvoke r1.<org.apache.dubbo.remoting.http12.message.codec.YamlCodecFactory: org.apache.dubbo.remoting.http12.message.MediaType mediaType()>();	$r3 = virtualinvoke $r2.<org.apache.dubbo.remoting.http12.message.MediaType: java.lang.String getName()>();	$z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>($r3);	if $z0 != 0 goto $z2 = 1;	$z2 = 1;	goto [?= return $z2];	return $z2
;block_num 3