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

(declare-sort var1620 0)
(declare-sort var2205 0)
(declare-sort var3476 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun mediaType/1513600551 (var1620) var2205)
(declare-fun getName/761802846 (var2205) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun charset/1513600551 (var1620) var3476)
(declare-fun name/1362759805 (var3476) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1620 var1620)
(declare-const var265 var1620) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.h12.HttpMessageEncoderWrapper 
(assert (not (= var265 null-var1620)))
(define-const var2869 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2869)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2869!1 String)
(assert (= var2869!1 ""))
(define-const var1027 var2205 (mediaType/1513600551 var265)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.h12.HttpMessageEncoderWrapper: org.apache.dubbo.remoting.http12.message.MediaType mediaType> 
(assert true)
(define-const var2725 String (getName/761802846 var1027)) ; Statement: $r3 = virtualinvoke $r2.<org.apache.dubbo.remoting.http12.message.MediaType: java.lang.String getName()>() 
(assert true)
(define-const var3370 String (append/672562846 var2869!1 var2725)) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var2869!2 String)
(assert (= var2869!2 (str.++ var2869!1 var2725)))
(assert true)
(define-const var3118 String (append/672562846 var3370 ";charset=")) ; Statement: $r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(";charset=") 
(declare-const var3370!1 String)
(assert (= var3370!1 (str.++ var3370 ";charset=")))
(define-const var1354 var3476 (charset/1513600551 var265)) ; Statement: $r5 = r1.<org.apache.dubbo.rpc.protocol.tri.h12.HttpMessageEncoderWrapper: java.nio.charset.Charset charset> 
(assert true)
(define-const var2132 String (name/1362759805 var1354)) ; Statement: $r6 = virtualinvoke $r5.<java.nio.charset.Charset: java.lang.String name()>() 
(assert true)
(define-const var3354 String (append/672562846 var3118 var2132)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var3118!1 String)
(assert (= var3118!1 (str.++ var3118 var2132)))
(assert true)
(define-const var1268 String (toString/-2075883882 var3354)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r9 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), mediaType/1513600551=([org.apache.dubbo.rpc.protocol.tri.h12.HttpMessageEncoderWrapper], org.apache.dubbo.remoting.http12.message.MediaType), getName/761802846=([org.apache.dubbo.remoting.http12.message.MediaType], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), charset/1513600551=([org.apache.dubbo.rpc.protocol.tri.h12.HttpMessageEncoderWrapper], java.nio.charset.Charset), name/1362759805=([java.nio.charset.Charset], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1620=org.apache.dubbo.rpc.protocol.tri.h12.HttpMessageEncoderWrapper, var265=r1, var2869=$r0, var2205=org.apache.dubbo.remoting.http12.message.MediaType, var1027=$r2, var2725=$r3, var3370=$r4, var3118=$r7, var3476=java.nio.charset.Charset, var1354=$r5, var2132=$r6, var3354=$r8, var1268=$r9}
; {org.apache.dubbo.rpc.protocol.tri.h12.HttpMessageEncoderWrapper=var1620, r1=var265, $r0=var2869, org.apache.dubbo.remoting.http12.message.MediaType=var2205, $r2=var1027, $r3=var2725, $r4=var3370, $r7=var3118, java.nio.charset.Charset=var3476, $r5=var1354, $r6=var2132, $r8=var3354, $r9=var1268}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.h12.HttpMessageEncoderWrapper;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = r1.<org.apache.dubbo.rpc.protocol.tri.h12.HttpMessageEncoderWrapper: org.apache.dubbo.remoting.http12.message.MediaType mediaType>;	$r3 = virtualinvoke $r2.<org.apache.dubbo.remoting.http12.message.MediaType: java.lang.String getName()>();	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(";charset=");	$r5 = r1.<org.apache.dubbo.rpc.protocol.tri.h12.HttpMessageEncoderWrapper: java.nio.charset.Charset charset>;	$r6 = virtualinvoke $r5.<java.nio.charset.Charset: java.lang.String name()>();	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	return $r9
;block_num 1