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

(declare-sort var2923 0)
(declare-sort var2098 0)
(declare-sort var3802 0)
(declare-sort var1627 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1627-init () var1627)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/1936416028 (var1627 String) void)
(declare-const null-var2923 var2923)
(declare-const null-var2098 var2098)
(declare-const null-String String)
(declare-const var2735 var2923) ; Statement: r7 := @this: org.apache.dubbo.common.bytecode.Wrapper$1 
(assert (not (= var2735 null-var2923)))
(declare-const var662 var2098) ; Statement: r8 := @parameter0: java.lang.Object 
(assert (not (= var662 null-var2098)))
(declare-const var2856 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2856 null-String)))
(define-const var1212 var1627 var1627-init) ; Statement: $r0 = new org.apache.dubbo.common.bytecode.NoSuchPropertyException 
(define-const var1866 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1866)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1866!1 String)
(assert (= var1866!1 ""))
(assert true)
(define-const var424 String (append/672562846 var1866!1 "Property [")) ; Statement: $r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Property [") 
(declare-const var1866!2 String)
(assert (= var1866!2 (str.++ var1866!1 "Property [")))
(assert true)
(define-const var2284 String (append/672562846 var424 var2856)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var424!1 String)
(assert (= var424!1 (str.++ var424 var2856)))
(assert true)
(define-const var1697 String (append/672562846 var2284 "] not found.")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] not found.") 
(declare-const var2284!1 String)
(assert (= var2284!1 (str.++ var2284 "] not found.")))
(assert true)
(define-const var1559 String (toString/-2075883882 var1697)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/1936416028 var1212 var1559)) ; Statement: specialinvoke $r0.<org.apache.dubbo.common.bytecode.NoSuchPropertyException: void <init>(java.lang.String)>($r6) 

(declare-const var1212!1 var1627)
(declare-const var1559!1 String)
 ; Statement: throw $r0 
(check-sat)
; {var1627-init=([], org.apache.dubbo.common.bytecode.NoSuchPropertyException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/1936416028=([org.apache.dubbo.common.bytecode.NoSuchPropertyException, java.lang.String], void)}
; {var2923=org.apache.dubbo.common.bytecode.Wrapper$1, var2735=r7, var2098=java.lang.Object, var662=r8, var2856=r2, var3802=null_type, var1627=org.apache.dubbo.common.bytecode.NoSuchPropertyException, var1212=$r0, var1866=$r1, var424=$r3, var2284=$r4, var1697=$r5, var1559=$r6}
; {org.apache.dubbo.common.bytecode.Wrapper$1=var2923, r7=var2735, java.lang.Object=var2098, r8=var662, r2=var2856, null_type=var3802, org.apache.dubbo.common.bytecode.NoSuchPropertyException=var1627, $r0=var1212, $r1=var1866, $r3=var424, $r4=var2284, $r5=var1697, $r6=var1559}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r7 := @this: org.apache.dubbo.common.bytecode.Wrapper$1;	r8 := @parameter0: java.lang.Object;	r2 := @parameter1: java.lang.String;	$r0 = new org.apache.dubbo.common.bytecode.NoSuchPropertyException;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Property [");	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] not found.");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r0.<org.apache.dubbo.common.bytecode.NoSuchPropertyException: void <init>(java.lang.String)>($r6);	throw $r0
;block_num 1