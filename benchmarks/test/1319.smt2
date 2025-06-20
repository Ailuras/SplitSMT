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

(declare-sort var1346 0)
(declare-sort var1382 0)
(declare-sort var2159 0)
(declare-sort var3634 0)
(declare-sort var2144 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun checkDestroyed/508264660 (var1346) void)
(declare-fun getBean/1284527661 (var1346 String ClassObject) var2159)
(declare-fun var2144-init () var2144)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-661438087 (var2144 String var3634) void)
(declare-const null-var1346 var1346)
(declare-const null-String String)
(declare-const null-ClassObject ClassObject)
(declare-const null-var2159 var2159)
(declare-const null-var3634 var3634)
(declare-const var1606 var1346) ; Statement: r0 := @this: org.apache.dubbo.common.beans.factory.ScopeBeanFactory 
(assert (not (= var1606 null-var1346)))
(declare-const var3971 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3971 null-String)))
(declare-const var2211 ClassObject) ; Statement: r2 := @parameter1: java.lang.Class 
(assert (not (= var2211 null-ClassObject)))
(assert true)
;(assert (checkDestroyed/508264660 var1606)) ; Statement: specialinvoke r0.<org.apache.dubbo.common.beans.factory.ScopeBeanFactory: void checkDestroyed()>() 

(declare-const var1606!1 var1346)
(assert true)
(define-const var1082 var2159 (getBean/1284527661 var1606!1 var3971 var2211)) ; Statement: r19 = virtualinvoke r0.<org.apache.dubbo.common.beans.factory.ScopeBeanFactory: java.lang.Object getBean(java.lang.String,java.lang.Class)>(r1, r2) 
 ; Statement: if r19 == null goto $r3 = r0.<org.apache.dubbo.common.beans.factory.ScopeBeanFactory: org.apache.dubbo.common.beans.support.InstantiationStrategy instantiationStrategy> 
(assert (not (= var1082 null-var2159))) ; Negate: Cond: r19 == null  
(declare-const var3208 var3634) ; Statement: $r12 := @caughtexception 
(assert (not (= var3208 null-var3634)))
(define-const var901 var2144 var2144-init) ; Statement: $r13 = new org.apache.dubbo.common.beans.ScopeBeanException 
(define-const var480 String String-init) ; Statement: $r14 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var480)) ; Statement: specialinvoke $r14.<java.lang.StringBuilder: void <init>()>() 
(declare-const var480!1 String)
(assert (= var480!1 ""))
(assert true)
(define-const var1522 String (append/672562846 var480!1 "create bean instance failed, type=")) ; Statement: $r16 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("create bean instance failed, type=") 
(declare-const var480!2 String)
(assert (= var480!2 (str.++ var480!1 "create bean instance failed, type=")))
(assert true)
(define-const var2501 String (getName/-1958580599 var2211)) ; Statement: $r15 = virtualinvoke r2.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var3448 String (append/672562846 var1522 var2501)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15) 
(declare-const var1522!1 String)
(assert (= var1522!1 (str.++ var1522 var2501)))
(assert true)
(define-const var1448 String (toString/-2075883882 var3448)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-661438087 var901 var1448 var3208)) ; Statement: specialinvoke $r13.<org.apache.dubbo.common.beans.ScopeBeanException: void <init>(java.lang.String,java.lang.Throwable)>($r18, $r12) 

(declare-const var901!1 var2144)
(declare-const var1448!1 String)
(declare-const var3208!1 var3634)
 ; Statement: throw $r13 
(check-sat)
; {checkDestroyed/508264660=([org.apache.dubbo.common.beans.factory.ScopeBeanFactory], void), getBean/1284527661=([org.apache.dubbo.common.beans.factory.ScopeBeanFactory, java.lang.String, java.lang.Class], java.lang.Object), var2144-init=([], org.apache.dubbo.common.beans.ScopeBeanException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getName/-1958580599=([java.lang.Class], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-661438087=([org.apache.dubbo.common.beans.ScopeBeanException, java.lang.String, java.lang.Throwable], void)}
; {var1346=org.apache.dubbo.common.beans.factory.ScopeBeanFactory, var1606=r0, var3971=r1, var1382=null_type, var2211=r2, var2159=java.lang.Object, var1082=r19, var3634=java.lang.Throwable, var3208=$r12, var2144=org.apache.dubbo.common.beans.ScopeBeanException, var901=$r13, var480=$r14, var1522=$r16, var2501=$r15, var3448=$r17, var1448=$r18}
; {org.apache.dubbo.common.beans.factory.ScopeBeanFactory=var1346, r0=var1606, r1=var3971, null_type=var1382, r2=var2211, java.lang.Object=var2159, r19=var1082, java.lang.Throwable=var3634, $r12=var3208, org.apache.dubbo.common.beans.ScopeBeanException=var2144, $r13=var901, $r14=var480, $r16=var1522, $r15=var2501, $r17=var3448, $r18=var1448}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.beans.factory.ScopeBeanFactory;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.Class;	specialinvoke r0.<org.apache.dubbo.common.beans.factory.ScopeBeanFactory: void checkDestroyed()>();	r19 = virtualinvoke r0.<org.apache.dubbo.common.beans.factory.ScopeBeanFactory: java.lang.Object getBean(java.lang.String,java.lang.Class)>(r1, r2);	if r19 == null goto $r3 = r0.<org.apache.dubbo.common.beans.factory.ScopeBeanFactory: org.apache.dubbo.common.beans.support.InstantiationStrategy instantiationStrategy>;	$r12 := @caughtexception;	$r13 = new org.apache.dubbo.common.beans.ScopeBeanException;	$r14 = new java.lang.StringBuilder;	specialinvoke $r14.<java.lang.StringBuilder: void <init>()>();	$r16 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("create bean instance failed, type=");	$r15 = virtualinvoke r2.<java.lang.Class: java.lang.String getName()>();	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15);	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r13.<org.apache.dubbo.common.beans.ScopeBeanException: void <init>(java.lang.String,java.lang.Throwable)>($r18, $r12);	throw $r13
;block_num 2