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

(declare-sort var3851 0)
(declare-sort var1126 0)
(declare-sort var3932 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/1180346878 (var3932 String Int) void)
(declare-fun cast-from-var3851-to-var3932 (var3851) var3932)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun name/1633728430 (var3932) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun className/-280708951 (var3851) String)
(declare-const null-var3851 var3851)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2050 var3851) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.Annotations 
(assert (not (= var2050 null-var3851)))
(declare-const var635 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var635 null-String)))
(declare-const var2201 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var2201 null-Int)))
(assert true)
;(assert (<init>/1180346878 (cast-from-var3851-to-var3932 var2050) var635 var2201)) ; Statement: specialinvoke r0.<java.lang.Enum: void <init>(java.lang.String,int)>(r1, i0) 

(declare-const var2050!1 var3851)
(declare-const var635!1 String)
(declare-const var2201!1 Int)
(define-const var2009 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2009)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2009!1 String)
(assert (= var2009!1 ""))
(assert true)
(define-const var1692 String (append/672562846 var2009!1 "javax.ws.rs.")) ; Statement: $r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("javax.ws.rs.") 
(declare-const var2009!2 String)
(assert (= var2009!2 (str.++ var2009!1 "javax.ws.rs.")))
(assert true)
(define-const var1576 String (name/1633728430 (cast-from-var3851-to-var3932 var2050!1))) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.Annotations: java.lang.String name()>() 
(assert true)
(define-const var494 String (append/672562846 var1692 var1576)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var1692!1 String)
(assert (= var1692!1 (str.++ var1692 var1576)))
(assert true)
(define-const var1301 String (toString/-2075883882 var494)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(declare-const var2050!2 var3851)
(assert (not (= var2050!2 null-var3851)))
(assert (= (className/-280708951 var2050!2) var1301)) ; Statement: r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.Annotations: java.lang.String className> = $r6 
 ; Statement: return 
(check-sat)
; {<init>/1180346878=([java.lang.Enum, java.lang.String, int], void), cast-from-var3851-to-var3932=([org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.Annotations], java.lang.Enum), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), name/1633728430=([java.lang.Enum], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), className/-280708951=([org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.Annotations], java.lang.String)}
; {var3851=org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.Annotations, var2050=r0, var635=r1, var1126=null_type, var2201=i0, var3932=java.lang.Enum, var2009=$r2, var1692=$r4, var1576=$r3, var494=$r5, var1301=$r6}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.Annotations=var3851, r0=var2050, r1=var635, null_type=var1126, i0=var2201, java.lang.Enum=var3932, $r2=var2009, $r4=var1692, $r3=var1576, $r5=var494, $r6=var1301}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.Annotations;	r1 := @parameter0: java.lang.String;	i0 := @parameter1: int;	specialinvoke r0.<java.lang.Enum: void <init>(java.lang.String,int)>(r1, i0);	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("javax.ws.rs.");	$r3 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.Annotations: java.lang.String name()>();	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.Annotations: java.lang.String className> = $r6;	return
;block_num 1