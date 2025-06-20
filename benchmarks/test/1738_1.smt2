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

(declare-sort var260 0)
(declare-sort var3145 0)
(declare-sort var1156 0)
(declare-sort var1074 0)
(declare-sort var2177 0)
(declare-sort var3395 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun checkDestroyed/508264660 (var260) void)
(declare-fun var2177-init () var2177)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getClass/1258963082 (var1156) ClassObject)
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-661438087 (var2177 String var3395) void)
(declare-fun cast-from-var1074-to-var3395 (var1074) var3395)
(declare-const null-var260 var260)
(declare-const null-String String)
(declare-const null-var1156 var1156)
(declare-const null-var1074 var1074)
(declare-const var1239 var260) ; Statement: r0 := @this: org.apache.dubbo.common.beans.factory.ScopeBeanFactory 
(assert (not (= var1239 null-var260)))
(declare-const var2367 String) ; Statement: r5 := @parameter0: java.lang.String 
(assert (not (= var2367 null-String)))
(declare-const var3623 var1156) ; Statement: r1 := @parameter1: java.lang.Object 
(assert (not (= var3623 null-var1156)))
(assert true)
;(assert (checkDestroyed/508264660 var1239)) ; Statement: specialinvoke r0.<org.apache.dubbo.common.beans.factory.ScopeBeanFactory: void checkDestroyed()>() 

(declare-const var1239!1 var260)
(define-const var1973 Bool false) ; Statement: $z0 = r1 instanceof org.apache.dubbo.common.extension.ExtensionAccessorAware 
 ; Statement: if $z0 == 0 goto $r2 = r0.<org.apache.dubbo.common.beans.factory.ScopeBeanFactory: java.util.List extensionPostProcessors> 
(assert (not (= (ite var1973 1 0) 0))) ; Negate: Cond: $z0 == 0  
(declare-const var1262 var1074) ; Statement: $r9 := @caughtexception 
(assert (not (= var1262 null-var1074)))
(define-const var2840 var2177 var2177-init) ; Statement: $r10 = new org.apache.dubbo.common.beans.ScopeBeanException 
(define-const var3746 String String-init) ; Statement: $r11 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3746)) ; Statement: specialinvoke $r11.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3746!1 String)
(assert (= var3746!1 ""))
(assert true)
(define-const var1175 String (append/672562846 var3746!1 "register bean failed! name=")) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("register bean failed! name=") 
(declare-const var3746!2 String)
(assert (= var3746!2 (str.++ var3746!1 "register bean failed! name=")))
(assert true)
(define-const var3528 String (append/672562846 var1175 var2367)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r5) 
(declare-const var1175!1 String)
(assert (= var1175!1 (str.++ var1175 var2367)))
(assert true)
(define-const var2781 String (append/672562846 var3528 ", type=")) ; Statement: $r16 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", type=") 
(declare-const var3528!1 String)
(assert (= var3528!1 (str.++ var3528 ", type=")))
(assert true)
(define-const var376 ClassObject (getClass/1258963082 var3623)) ; Statement: $r14 = virtualinvoke r1.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var204 String (getName/-1958580599 var376)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var1410 String (append/672562846 var2781 var204)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15) 
(declare-const var2781!1 String)
(assert (= var2781!1 (str.++ var2781 var204)))
(assert true)
(define-const var691 String (toString/-2075883882 var1410)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-661438087 var2840 var691 (cast-from-var1074-to-var3395 var1262))) ; Statement: specialinvoke $r10.<org.apache.dubbo.common.beans.ScopeBeanException: void <init>(java.lang.String,java.lang.Throwable)>($r18, $r9) 

(declare-const var2840!1 var2177)
(declare-const var691!1 String)
(declare-const var1262!1 var1074)
 ; Statement: throw $r10 
(check-sat)
; {checkDestroyed/508264660=([org.apache.dubbo.common.beans.factory.ScopeBeanFactory], void), var2177-init=([], org.apache.dubbo.common.beans.ScopeBeanException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getClass/1258963082=([java.lang.Object], java.lang.Class), getName/-1958580599=([java.lang.Class], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-661438087=([org.apache.dubbo.common.beans.ScopeBeanException, java.lang.String, java.lang.Throwable], void), cast-from-var1074-to-var3395=([java.lang.Exception], java.lang.Throwable)}
; {var260=org.apache.dubbo.common.beans.factory.ScopeBeanFactory, var1239=r0, var2367=r5, var3145=null_type, var1156=java.lang.Object, var3623=r1, var1973=$z0, var1074=java.lang.Exception, var1262=$r9, var2177=org.apache.dubbo.common.beans.ScopeBeanException, var2840=$r10, var3746=$r11, var1175=$r12, var3528=$r13, var2781=$r16, var376=$r14, var204=$r15, var1410=$r17, var691=$r18, var3395=java.lang.Throwable}
; {org.apache.dubbo.common.beans.factory.ScopeBeanFactory=var260, r0=var1239, r5=var2367, null_type=var3145, java.lang.Object=var1156, r1=var3623, $z0=var1973, java.lang.Exception=var1074, $r9=var1262, org.apache.dubbo.common.beans.ScopeBeanException=var2177, $r10=var2840, $r11=var3746, $r12=var1175, $r13=var3528, $r16=var2781, $r14=var376, $r15=var204, $r17=var1410, $r18=var691, java.lang.Throwable=var3395}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.beans.factory.ScopeBeanFactory;	r5 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.Object;	specialinvoke r0.<org.apache.dubbo.common.beans.factory.ScopeBeanFactory: void checkDestroyed()>();	$z0 = r1 instanceof org.apache.dubbo.common.extension.ExtensionAccessorAware;	if $z0 == 0 goto $r2 = r0.<org.apache.dubbo.common.beans.factory.ScopeBeanFactory: java.util.List extensionPostProcessors>;	$r9 := @caughtexception;	$r10 = new org.apache.dubbo.common.beans.ScopeBeanException;	$r11 = new java.lang.StringBuilder;	specialinvoke $r11.<java.lang.StringBuilder: void <init>()>();	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("register bean failed! name=");	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r5);	$r16 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", type=");	$r14 = virtualinvoke r1.<java.lang.Object: java.lang.Class getClass()>();	$r15 = virtualinvoke $r14.<java.lang.Class: java.lang.String getName()>();	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15);	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r10.<org.apache.dubbo.common.beans.ScopeBeanException: void <init>(java.lang.String,java.lang.Throwable)>($r18, $r9);	throw $r10
;block_num 2