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

(declare-sort var2649 0)
(declare-sort var3066 0)
(declare-sort var1280 0)
(declare-sort var2655 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun checkDestroyed/508264660 (var2649) void)
(declare-fun getBean/1284527661 (var2649 String ClassObject) var1280)
(declare-fun var2655-init () var2655)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/192024761 (var2655 String) void)
(declare-const null-var2649 var2649)
(declare-const null-String String)
(declare-const null-ClassObject ClassObject)
(declare-const null-var1280 var1280)
(declare-const var2415 var2649) ; Statement: r0 := @this: org.apache.dubbo.common.beans.factory.ScopeBeanFactory 
(assert (not (= var2415 null-var2649)))
(declare-const var1540 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1540 null-String)))
(declare-const var2689 ClassObject) ; Statement: r2 := @parameter1: java.lang.Class 
(assert (not (= var2689 null-ClassObject)))
(assert true)
;(assert (checkDestroyed/508264660 var2415)) ; Statement: specialinvoke r0.<org.apache.dubbo.common.beans.factory.ScopeBeanFactory: void checkDestroyed()>() 

(declare-const var2415!1 var2649)
(assert true)
(define-const var591 var1280 (getBean/1284527661 var2415!1 var1540 var2689)) ; Statement: r19 = virtualinvoke r0.<org.apache.dubbo.common.beans.factory.ScopeBeanFactory: java.lang.Object getBean(java.lang.String,java.lang.Class)>(r1, r2) 
 ; Statement: if r19 == null goto $r3 = r0.<org.apache.dubbo.common.beans.factory.ScopeBeanFactory: org.apache.dubbo.common.beans.support.InstantiationStrategy instantiationStrategy> 
(assert (not (= var591 null-var1280))) ; Negate: Cond: r19 == null  
(define-const var2161 var2655 var2655-init) ; Statement: $r4 = new org.apache.dubbo.common.beans.ScopeBeanException 
(define-const var956 String String-init) ; Statement: $r5 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var956)) ; Statement: specialinvoke $r5.<java.lang.StringBuilder: void <init>()>() 
(declare-const var956!1 String)
(assert (= var956!1 ""))
(assert true)
(define-const var1293 String (append/672562846 var956!1 "already exists bean with same name and type, name=")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("already exists bean with same name and type, name=") 
(declare-const var956!2 String)
(assert (= var956!2 (str.++ var956!1 "already exists bean with same name and type, name=")))
(assert true)
(define-const var2335 String (append/672562846 var1293 var1540)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var1293!1 String)
(assert (= var1293!1 (str.++ var1293 var1540)))
(assert true)
(define-const var3742 String (append/672562846 var2335 ", type=")) ; Statement: $r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", type=") 
(declare-const var2335!1 String)
(assert (= var2335!1 (str.++ var2335 ", type=")))
(assert true)
(define-const var3509 String (getName/-1958580599 var2689)) ; Statement: $r8 = virtualinvoke r2.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var251 String (append/672562846 var3742 var3509)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8) 
(declare-const var3742!1 String)
(assert (= var3742!1 (str.++ var3742 var3509)))
(assert true)
(define-const var886 String (toString/-2075883882 var251)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/192024761 var2161 var886)) ; Statement: specialinvoke $r4.<org.apache.dubbo.common.beans.ScopeBeanException: void <init>(java.lang.String)>($r11) 

(declare-const var2161!1 var2655)
(declare-const var886!1 String)
 ; Statement: throw $r4 
(check-sat)
; {checkDestroyed/508264660=([org.apache.dubbo.common.beans.factory.ScopeBeanFactory], void), getBean/1284527661=([org.apache.dubbo.common.beans.factory.ScopeBeanFactory, java.lang.String, java.lang.Class], java.lang.Object), var2655-init=([], org.apache.dubbo.common.beans.ScopeBeanException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getName/-1958580599=([java.lang.Class], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/192024761=([org.apache.dubbo.common.beans.ScopeBeanException, java.lang.String], void)}
; {var2649=org.apache.dubbo.common.beans.factory.ScopeBeanFactory, var2415=r0, var1540=r1, var3066=null_type, var2689=r2, var1280=java.lang.Object, var591=r19, var2655=org.apache.dubbo.common.beans.ScopeBeanException, var2161=$r4, var956=$r5, var1293=$r6, var2335=$r7, var3742=$r9, var3509=$r8, var251=$r10, var886=$r11}
; {org.apache.dubbo.common.beans.factory.ScopeBeanFactory=var2649, r0=var2415, r1=var1540, null_type=var3066, r2=var2689, java.lang.Object=var1280, r19=var591, org.apache.dubbo.common.beans.ScopeBeanException=var2655, $r4=var2161, $r5=var956, $r6=var1293, $r7=var2335, $r9=var3742, $r8=var3509, $r10=var251, $r11=var886}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.beans.factory.ScopeBeanFactory;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.Class;	specialinvoke r0.<org.apache.dubbo.common.beans.factory.ScopeBeanFactory: void checkDestroyed()>();	r19 = virtualinvoke r0.<org.apache.dubbo.common.beans.factory.ScopeBeanFactory: java.lang.Object getBean(java.lang.String,java.lang.Class)>(r1, r2);	if r19 == null goto $r3 = r0.<org.apache.dubbo.common.beans.factory.ScopeBeanFactory: org.apache.dubbo.common.beans.support.InstantiationStrategy instantiationStrategy>;	$r4 = new org.apache.dubbo.common.beans.ScopeBeanException;	$r5 = new java.lang.StringBuilder;	specialinvoke $r5.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("already exists bean with same name and type, name=");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", type=");	$r8 = virtualinvoke r2.<java.lang.Class: java.lang.String getName()>();	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r4.<org.apache.dubbo.common.beans.ScopeBeanException: void <init>(java.lang.String)>($r11);	throw $r4
;block_num 2