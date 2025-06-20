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

(declare-sort var2547 0)
(declare-sort var373 0)
(declare-sort var3911 0)
(declare-sort var1864 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1864-init () var1864)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/1936416028 (var1864 String) void)
(declare-const null-var2547 var2547)
(declare-const null-var373 var373)
(declare-const null-String String)
(declare-const var3063 var2547) ; Statement: r7 := @this: org.apache.dubbo.common.bytecode.Wrapper$1 
(assert (not (= var3063 null-var2547)))
(declare-const var1223 var373) ; Statement: r8 := @parameter0: java.lang.Object 
(assert (not (= var1223 null-var373)))
(declare-const var3385 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var3385 null-String)))
(declare-const var334 var373) ; Statement: r9 := @parameter2: java.lang.Object 
(assert (not (= var334 null-var373)))
(define-const var695 var1864 var1864-init) ; Statement: $r0 = new org.apache.dubbo.common.bytecode.NoSuchPropertyException 
(define-const var2484 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2484)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2484!1 String)
(assert (= var2484!1 ""))
(assert true)
(define-const var3136 String (append/672562846 var2484!1 "Property [")) ; Statement: $r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Property [") 
(declare-const var2484!2 String)
(assert (= var2484!2 (str.++ var2484!1 "Property [")))
(assert true)
(define-const var3403 String (append/672562846 var3136 var3385)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var3136!1 String)
(assert (= var3136!1 (str.++ var3136 var3385)))
(assert true)
(define-const var1603 String (append/672562846 var3403 "] not found.")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] not found.") 
(declare-const var3403!1 String)
(assert (= var3403!1 (str.++ var3403 "] not found.")))
(assert true)
(define-const var1509 String (toString/-2075883882 var1603)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/1936416028 var695 var1509)) ; Statement: specialinvoke $r0.<org.apache.dubbo.common.bytecode.NoSuchPropertyException: void <init>(java.lang.String)>($r6) 

(declare-const var695!1 var1864)
(declare-const var1509!1 String)
 ; Statement: throw $r0 
(check-sat)
; {var1864-init=([], org.apache.dubbo.common.bytecode.NoSuchPropertyException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/1936416028=([org.apache.dubbo.common.bytecode.NoSuchPropertyException, java.lang.String], void)}
; {var2547=org.apache.dubbo.common.bytecode.Wrapper$1, var3063=r7, var373=java.lang.Object, var1223=r8, var3385=r2, var3911=null_type, var334=r9, var1864=org.apache.dubbo.common.bytecode.NoSuchPropertyException, var695=$r0, var2484=$r1, var3136=$r3, var3403=$r4, var1603=$r5, var1509=$r6}
; {org.apache.dubbo.common.bytecode.Wrapper$1=var2547, r7=var3063, java.lang.Object=var373, r8=var1223, r2=var3385, null_type=var3911, r9=var334, org.apache.dubbo.common.bytecode.NoSuchPropertyException=var1864, $r0=var695, $r1=var2484, $r3=var3136, $r4=var3403, $r5=var1603, $r6=var1509}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r7 := @this: org.apache.dubbo.common.bytecode.Wrapper$1;	r8 := @parameter0: java.lang.Object;	r2 := @parameter1: java.lang.String;	r9 := @parameter2: java.lang.Object;	$r0 = new org.apache.dubbo.common.bytecode.NoSuchPropertyException;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Property [");	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] not found.");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r0.<org.apache.dubbo.common.bytecode.NoSuchPropertyException: void <init>(java.lang.String)>($r6);	throw $r0
;block_num 1