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

(declare-sort var3541 0)
(declare-sort var842 0)
(declare-sort var1930 0)
(declare-sort var1665 0)
(declare-sort var3644 0)
(declare-sort var370 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var842-init () var842)
(declare-fun <init>/-707998177 (var842) void)
(declare-fun arr-Int-init () (Array Int Int))
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var370_getClass/1258963082 (var370) ClassObject)
(declare-fun cast-from-var3541-to-var370 (var3541) var370)
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1665_warn/1431914100 (var1665 String String String String) void)
(declare-const null-var3541 var3541)
(declare-const null-Int Int)
(declare-const null-var1930 var1930)
(declare-const var3644-logger var1665)
(declare-const var1165 var3541) ; Statement: r1 := @parameter0: org.apache.dubbo.common.serialize.Serialization 
(assert (not (= var1165 null-var3541)))
(declare-const var3978 Int) ; Statement: r11 := @parameter1: java.lang.Byte 
(assert (not (= var3978 null-Int)))
(define-const var3048 var842 var842-init) ; Statement: $r0 = new java.io.ByteArrayOutputStream 
(assert true)
;(assert (<init>/-707998177 var3048)) ; Statement: specialinvoke $r0.<java.io.ByteArrayOutputStream: void <init>()>() 

(declare-const var3048!1 var842)
(define-const var1497 (Array Int Int) arr-Int-init) ; Statement: r12 = newarray (byte)[0] 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2719 var1930) ; Statement: $r2 := @caughtexception 
(assert (not (= var2719 null-var1930)))
(define-const var2847 var1665 var3644-logger) ; Statement: $r4 = <org.apache.dubbo.remoting.transport.CodecSupport: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1852 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1852)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1852!1 String)
(assert (= var1852!1 ""))
(assert true)
(define-const var1251 String (append/672562846 var1852!1 "Serialization extension ")) ; Statement: $r7 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Serialization extension ") 
(declare-const var1852!2 String)
(assert (= var1852!2 (str.++ var1852!1 "Serialization extension ")))
(define-const var2332 ClassObject (var370_getClass/1258963082 (cast-from-var3541-to-var370 var1165))) ; Statement: $r5 = interfaceinvoke r1.<org.apache.dubbo.common.serialize.Serialization: java.lang.Class getClass()>() 
(assert true)
(define-const var3373 String (getName/-1958580599 var2332)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var1179 String (append/672562846 var1251 var3373)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var1251!1 String)
(assert (= var1251!1 (str.++ var1251 var3373)))
(assert true)
(define-const var1236 String (append/672562846 var1179 " not support serializing null object, return an empty bytes instead.")) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" not support serializing null object, return an empty bytes instead.") 
(declare-const var1179!1 String)
(assert (= var1179!1 (str.++ var1179 " not support serializing null object, return an empty bytes instead.")))
(assert true)
(define-const var3963 String (toString/-2075883882 var1236)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var1665_warn/1431914100 var2847 "6-9" "" "" var3963)) ; Statement: interfaceinvoke $r4.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("6-9", "", "", $r10) 

(declare-const var2847!1 var1665)
(declare-const var1021 String)
(declare-const var1885 String)
(declare-const var1885!1 String)
(declare-const var3963!1 String)
(assert true) ; Non Conditional
 ; Statement: return r12 
(check-sat)
; {var842-init=([], java.io.ByteArrayOutputStream), <init>/-707998177=([java.io.ByteArrayOutputStream], void), arr-Int-init=([], byte[]), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var370_getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var3541-to-var370=([org.apache.dubbo.common.serialize.Serialization], java.lang.Object), getName/-1958580599=([java.lang.Class], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1665_warn/1431914100=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String], void)}
; {var3541=org.apache.dubbo.common.serialize.Serialization, var1165=r1, var3978=r11, var842=java.io.ByteArrayOutputStream, var3048=$r0, var1497=r12, var1930=java.lang.Exception, var2719=$r2, var1665=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3644=org.apache.dubbo.remoting.transport.CodecSupport, var2847=$r4, var1852=$r3, var1251=$r7, var370=java.lang.Object, var2332=$r5, var3373=$r6, var1179=$r8, var1236=$r9, var3963=$r10, var1021="6-9", var1885=""}
; {org.apache.dubbo.common.serialize.Serialization=var3541, r1=var1165, r11=var3978, java.io.ByteArrayOutputStream=var842, $r0=var3048, r12=var1497, java.lang.Exception=var1930, $r2=var2719, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1665, org.apache.dubbo.remoting.transport.CodecSupport=var3644, $r4=var2847, $r3=var1852, $r7=var1251, java.lang.Object=var370, $r5=var2332, $r6=var3373, $r8=var1179, $r9=var1236, $r10=var3963, "6-9"=var1021, ""=var1885}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: org.apache.dubbo.common.serialize.Serialization;	r11 := @parameter1: java.lang.Byte;	$r0 = new java.io.ByteArrayOutputStream;	specialinvoke $r0.<java.io.ByteArrayOutputStream: void <init>()>();	r12 = newarray (byte)[0];	$r2 := @caughtexception;	$r4 = <org.apache.dubbo.remoting.transport.CodecSupport: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r7 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Serialization extension ");	$r5 = interfaceinvoke r1.<org.apache.dubbo.common.serialize.Serialization: java.lang.Class getClass()>();	$r6 = virtualinvoke $r5.<java.lang.Class: java.lang.String getName()>();	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" not support serializing null object, return an empty bytes instead.");	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r4.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("6-9", "", "", $r10);	return r12
;block_num 3