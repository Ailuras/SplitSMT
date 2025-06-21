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

(declare-sort var1155 0)
(declare-sort var1290 0)
(declare-sort var992 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/1180346878 (var992 String Int) void)
(declare-fun cast-from-var1155-to-var992 (var1155) var992)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun name/1633728430 (var992) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun className/-810535243 (var1155) String)
(declare-const null-var1155 var1155)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2008 var1155) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.basic.Annotations 
(assert (not (= var2008 null-var1155)))
(declare-const var2366 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2366 null-String)))
(declare-const var335 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var335 null-Int)))
(assert true)
;(assert (<init>/1180346878 (cast-from-var1155-to-var992 var2008) var2366 var335)) ; Statement: specialinvoke r0.<java.lang.Enum: void <init>(java.lang.String,int)>(r1, i0) 

(declare-const var2008!1 var1155)
(declare-const var2366!1 String)
(declare-const var335!1 Int)
(define-const var1569 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1569)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1569!1 String)
(assert (= var1569!1 ""))
(assert true)
(define-const var3734 String (append/672562846 var1569!1 "org.apache.dubbo.remoting.http12.rest.")) ; Statement: $r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("org.apache.dubbo.remoting.http12.rest.") 
(declare-const var1569!2 String)
(assert (= var1569!2 (str.++ var1569!1 "org.apache.dubbo.remoting.http12.rest.")))
(assert true)
(define-const var1840 String (name/1633728430 (cast-from-var1155-to-var992 var2008!1))) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.basic.Annotations: java.lang.String name()>() 
(assert true)
(define-const var3527 String (append/672562846 var3734 var1840)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var3734!1 String)
(assert (= var3734!1 (str.++ var3734 var1840)))
(assert true)
(define-const var2824 String (toString/-2075883882 var3527)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(declare-const var2008!2 var1155)
(assert (not (= var2008!2 null-var1155)))
(assert (= (className/-810535243 var2008!2) var2824)) ; Statement: r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.basic.Annotations: java.lang.String className> = $r6 
 ; Statement: return 
(check-sat)
; {<init>/1180346878=([java.lang.Enum, java.lang.String, int], void), cast-from-var1155-to-var992=([org.apache.dubbo.rpc.protocol.tri.rest.support.basic.Annotations], java.lang.Enum), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), name/1633728430=([java.lang.Enum], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), className/-810535243=([org.apache.dubbo.rpc.protocol.tri.rest.support.basic.Annotations], java.lang.String)}
; {var1155=org.apache.dubbo.rpc.protocol.tri.rest.support.basic.Annotations, var2008=r0, var2366=r1, var1290=null_type, var335=i0, var992=java.lang.Enum, var1569=$r2, var3734=$r4, var1840=$r3, var3527=$r5, var2824=$r6}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.basic.Annotations=var1155, r0=var2008, r1=var2366, null_type=var1290, i0=var335, java.lang.Enum=var992, $r2=var1569, $r4=var3734, $r3=var1840, $r5=var3527, $r6=var2824}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.basic.Annotations;	r1 := @parameter0: java.lang.String;	i0 := @parameter1: int;	specialinvoke r0.<java.lang.Enum: void <init>(java.lang.String,int)>(r1, i0);	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("org.apache.dubbo.remoting.http12.rest.");	$r3 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.basic.Annotations: java.lang.String name()>();	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.basic.Annotations: java.lang.String className> = $r6;	return
;block_num 1