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

(declare-sort var1977 0)
(declare-sort var2167 0)
(declare-sort var1849 0)
(declare-sort var388 0)
(declare-sort var1807 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var1849) void)
(declare-fun cast-from-var1977-to-var1849 (var1977) var1849)
(declare-fun var388-init () var388)
(declare-fun <init>/-1461814690 (var388) void)
(declare-fun cast-from-var388-to-var1807 (var388) var1807)
(declare-fun properties/-1364397088 (var1977) var1807)
(declare-fun notEmpty/-1300339435 (var1977 String String) void)
(declare-fun isValidType/-58863226 (var1977 Int) Bool)
(declare-fun className/-1364397088 (var1977) String)
(declare-fun type/-1364397088 (var1977) Int)
(declare-const null-var1977 var1977)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var3376 var1977) ; Statement: r0 := @this: org.apache.dubbo.common.beanutil.JavaBeanDescriptor 
(assert (not (= var3376 null-var1977)))
(declare-const var341 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var341 null-String)))
(declare-const var2009 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var2009 null-Int)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var1977-to-var1849 var3376))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var3376!1 var1977)
(define-const var113 var388 var388-init) ; Statement: $r1 = new java.util.LinkedHashMap 
(assert true)
;(assert (<init>/-1461814690 var113)) ; Statement: specialinvoke $r1.<java.util.LinkedHashMap: void <init>()>() 

(declare-const var113!1 var388)
(declare-const var3376!2 var1977)
(assert (not (= var3376!2 null-var1977)))
(assert (= (properties/-1364397088 var3376!2) (cast-from-var388-to-var1807 var113!1))) ; Statement: r0.<org.apache.dubbo.common.beanutil.JavaBeanDescriptor: java.util.Map properties> = $r1 
(assert true)
;(assert (notEmpty/-1300339435 var3376!2 var341 "class name is empty")) ; Statement: specialinvoke r0.<org.apache.dubbo.common.beanutil.JavaBeanDescriptor: void notEmpty(java.lang.String,java.lang.String)>(r2, "class name is empty") 

(declare-const var3376!3 var1977)
(declare-const var341!1 String)
(declare-const var2516 String)
(assert true)
(define-const var2853 Bool (isValidType/-58863226 var3376!3 var2009)) ; Statement: $z0 = specialinvoke r0.<org.apache.dubbo.common.beanutil.JavaBeanDescriptor: boolean isValidType(int)>(i0) 
 ; Statement: if $z0 != 0 goto r0.<org.apache.dubbo.common.beanutil.JavaBeanDescriptor: java.lang.String className> = r2 
(assert (not (= (ite var2853 1 0) 0))) ; Cond: $z0 != 0 
(declare-const var3376!4 var1977)
(assert (not (= var3376!4 null-var1977)))
(assert (= (className/-1364397088 var3376!4) var341!1)) ; Statement: r0.<org.apache.dubbo.common.beanutil.JavaBeanDescriptor: java.lang.String className> = r2 
(declare-const var3376!5 var1977)
(assert (not (= var3376!5 null-var1977)))
(assert (= (type/-1364397088 var3376!5) var2009)) ; Statement: r0.<org.apache.dubbo.common.beanutil.JavaBeanDescriptor: int type> = i0 
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var1977-to-var1849=([org.apache.dubbo.common.beanutil.JavaBeanDescriptor], java.lang.Object), var388-init=([], java.util.LinkedHashMap), <init>/-1461814690=([java.util.LinkedHashMap], void), cast-from-var388-to-var1807=([java.util.LinkedHashMap], java.util.Map), properties/-1364397088=([org.apache.dubbo.common.beanutil.JavaBeanDescriptor], java.util.Map), notEmpty/-1300339435=([org.apache.dubbo.common.beanutil.JavaBeanDescriptor, java.lang.String, java.lang.String], void), isValidType/-58863226=([org.apache.dubbo.common.beanutil.JavaBeanDescriptor, int], boolean), className/-1364397088=([org.apache.dubbo.common.beanutil.JavaBeanDescriptor], java.lang.String), type/-1364397088=([org.apache.dubbo.common.beanutil.JavaBeanDescriptor], int)}
; {var1977=org.apache.dubbo.common.beanutil.JavaBeanDescriptor, var3376=r0, var341=r2, var2167=null_type, var2009=i0, var1849=java.lang.Object, var388=java.util.LinkedHashMap, var113=$r1, var1807=java.util.Map, var2516="class name is empty", var2853=$z0}
; {org.apache.dubbo.common.beanutil.JavaBeanDescriptor=var1977, r0=var3376, r2=var341, null_type=var2167, i0=var2009, java.lang.Object=var1849, java.util.LinkedHashMap=var388, $r1=var113, java.util.Map=var1807, "class name is empty"=var2516, $z0=var2853}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.common.beanutil.JavaBeanDescriptor;	r2 := @parameter0: java.lang.String;	i0 := @parameter1: int;	specialinvoke r0.<java.lang.Object: void <init>()>();	$r1 = new java.util.LinkedHashMap;	specialinvoke $r1.<java.util.LinkedHashMap: void <init>()>();	r0.<org.apache.dubbo.common.beanutil.JavaBeanDescriptor: java.util.Map properties> = $r1;	specialinvoke r0.<org.apache.dubbo.common.beanutil.JavaBeanDescriptor: void notEmpty(java.lang.String,java.lang.String)>(r2, "class name is empty");	$z0 = specialinvoke r0.<org.apache.dubbo.common.beanutil.JavaBeanDescriptor: boolean isValidType(int)>(i0);	if $z0 != 0 goto r0.<org.apache.dubbo.common.beanutil.JavaBeanDescriptor: java.lang.String className> = r2;	r0.<org.apache.dubbo.common.beanutil.JavaBeanDescriptor: java.lang.String className> = r2;	r0.<org.apache.dubbo.common.beanutil.JavaBeanDescriptor: int type> = i0;	return
;block_num 2