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

(declare-sort var681 0)
(declare-sort var2687 0)
(declare-sort var3261 0)
(declare-sort var2852 0)
(declare-sort var463 0)
(declare-sort var2704 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var3261) void)
(declare-fun cast-from-var681-to-var3261 (var681) var3261)
(declare-fun var2852-init () var2852)
(declare-fun <init>/-1461814690 (var2852) void)
(declare-fun cast-from-var2852-to-var463 (var2852) var463)
(declare-fun properties/-1364397088 (var681) var463)
(declare-fun notEmpty/-1300339435 (var681 String String) void)
(declare-fun isValidType/-58863226 (var681 Int) Bool)
(declare-fun var2704-init () var2704)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var2704 String) void)
(declare-const null-var681 var681)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var3713 var681) ; Statement: r0 := @this: org.apache.dubbo.common.beanutil.JavaBeanDescriptor 
(assert (not (= var3713 null-var681)))
(declare-const var3851 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var3851 null-String)))
(declare-const var652 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var652 null-Int)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var681-to-var3261 var3713))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var3713!1 var681)
(define-const var3164 var2852 var2852-init) ; Statement: $r1 = new java.util.LinkedHashMap 
(assert true)
;(assert (<init>/-1461814690 var3164)) ; Statement: specialinvoke $r1.<java.util.LinkedHashMap: void <init>()>() 

(declare-const var3164!1 var2852)
(declare-const var3713!2 var681)
(assert (not (= var3713!2 null-var681)))
(assert (= (properties/-1364397088 var3713!2) (cast-from-var2852-to-var463 var3164!1))) ; Statement: r0.<org.apache.dubbo.common.beanutil.JavaBeanDescriptor: java.util.Map properties> = $r1 
(assert true)
;(assert (notEmpty/-1300339435 var3713!2 var3851 "class name is empty")) ; Statement: specialinvoke r0.<org.apache.dubbo.common.beanutil.JavaBeanDescriptor: void notEmpty(java.lang.String,java.lang.String)>(r2, "class name is empty") 

(declare-const var3713!3 var681)
(declare-const var3851!1 String)
(declare-const var1945 String)
(assert true)
(define-const var2384 Bool (isValidType/-58863226 var3713!3 var652)) ; Statement: $z0 = specialinvoke r0.<org.apache.dubbo.common.beanutil.JavaBeanDescriptor: boolean isValidType(int)>(i0) 
 ; Statement: if $z0 != 0 goto r0.<org.apache.dubbo.common.beanutil.JavaBeanDescriptor: java.lang.String className> = r2 
(assert (not (not (= (ite var2384 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var363 var2704 var2704-init) ; Statement: $r3 = new java.lang.IllegalArgumentException 
(define-const var2382 String String-init) ; Statement: $r4 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2382)) ; Statement: specialinvoke $r4.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2382!1 String)
(assert (= var2382!1 ""))
(assert true)
(define-const var2957 String (append/672562846 var2382!1 "type [ ")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("type [ ") 
(declare-const var2382!2 String)
(assert (= var2382!2 (str.++ var2382!1 "type [ ")))
(assert true)
(define-const var3050 String (append/-1001720160 var2957 var652)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var2957!1 String)
(assert (str.prefixof var2957 var2957!1))
(assert true)
(define-const var3403 String (append/672562846 var3050 " ] is unsupported")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ] is unsupported") 
(declare-const var3050!1 String)
(assert (= var3050!1 (str.++ var3050 " ] is unsupported")))
(assert true)
(define-const var1958 String (toString/-2075883882 var3403)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var363 var1958)) ; Statement: specialinvoke $r3.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r8) 

(declare-const var363!1 var2704)
(declare-const var1958!1 String)
 ; Statement: throw $r3 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var681-to-var3261=([org.apache.dubbo.common.beanutil.JavaBeanDescriptor], java.lang.Object), var2852-init=([], java.util.LinkedHashMap), <init>/-1461814690=([java.util.LinkedHashMap], void), cast-from-var2852-to-var463=([java.util.LinkedHashMap], java.util.Map), properties/-1364397088=([org.apache.dubbo.common.beanutil.JavaBeanDescriptor], java.util.Map), notEmpty/-1300339435=([org.apache.dubbo.common.beanutil.JavaBeanDescriptor, java.lang.String, java.lang.String], void), isValidType/-58863226=([org.apache.dubbo.common.beanutil.JavaBeanDescriptor, int], boolean), var2704-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var681=org.apache.dubbo.common.beanutil.JavaBeanDescriptor, var3713=r0, var3851=r2, var2687=null_type, var652=i0, var3261=java.lang.Object, var2852=java.util.LinkedHashMap, var3164=$r1, var463=java.util.Map, var1945="class name is empty", var2384=$z0, var2704=java.lang.IllegalArgumentException, var363=$r3, var2382=$r4, var2957=$r5, var3050=$r6, var3403=$r7, var1958=$r8}
; {org.apache.dubbo.common.beanutil.JavaBeanDescriptor=var681, r0=var3713, r2=var3851, null_type=var2687, i0=var652, java.lang.Object=var3261, java.util.LinkedHashMap=var2852, $r1=var3164, java.util.Map=var463, "class name is empty"=var1945, $z0=var2384, java.lang.IllegalArgumentException=var2704, $r3=var363, $r4=var2382, $r5=var2957, $r6=var3050, $r7=var3403, $r8=var1958}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.beanutil.JavaBeanDescriptor;	r2 := @parameter0: java.lang.String;	i0 := @parameter1: int;	specialinvoke r0.<java.lang.Object: void <init>()>();	$r1 = new java.util.LinkedHashMap;	specialinvoke $r1.<java.util.LinkedHashMap: void <init>()>();	r0.<org.apache.dubbo.common.beanutil.JavaBeanDescriptor: java.util.Map properties> = $r1;	specialinvoke r0.<org.apache.dubbo.common.beanutil.JavaBeanDescriptor: void notEmpty(java.lang.String,java.lang.String)>(r2, "class name is empty");	$z0 = specialinvoke r0.<org.apache.dubbo.common.beanutil.JavaBeanDescriptor: boolean isValidType(int)>(i0);	if $z0 != 0 goto r0.<org.apache.dubbo.common.beanutil.JavaBeanDescriptor: java.lang.String className> = r2;	$r3 = new java.lang.IllegalArgumentException;	$r4 = new java.lang.StringBuilder;	specialinvoke $r4.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("type [ ");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ] is unsupported");	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r3.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r8);	throw $r3
;block_num 2