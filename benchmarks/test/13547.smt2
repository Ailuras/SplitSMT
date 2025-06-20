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

(declare-sort var3655 0)
(declare-sort var2939 0)
(declare-sort var2169 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/1180346878 (var2169 String Int) void)
(declare-fun cast-from-var3655-to-var2169 (var3655) var2169)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun name/1633728430 (var2169) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun className/1330807122 (var3655) String)
(declare-const null-var3655 var3655)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var1784 var3655) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.spring.Annotations 
(assert (not (= var1784 null-var3655)))
(declare-const var913 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var913 null-String)))
(declare-const var1324 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var1324 null-Int)))
(assert true)
;(assert (<init>/1180346878 (cast-from-var3655-to-var2169 var1784) var913 var1324)) ; Statement: specialinvoke r0.<java.lang.Enum: void <init>(java.lang.String,int)>(r1, i0) 

(declare-const var1784!1 var3655)
(declare-const var913!1 String)
(declare-const var1324!1 Int)
(define-const var574 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var574)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var574!1 String)
(assert (= var574!1 ""))
(assert true)
(define-const var1905 String (append/672562846 var574!1 "org.springframework.web.bind.annotation.")) ; Statement: $r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("org.springframework.web.bind.annotation.") 
(declare-const var574!2 String)
(assert (= var574!2 (str.++ var574!1 "org.springframework.web.bind.annotation.")))
(assert true)
(define-const var3701 String (name/1633728430 (cast-from-var3655-to-var2169 var1784!1))) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.spring.Annotations: java.lang.String name()>() 
(assert true)
(define-const var1845 String (append/672562846 var1905 var3701)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var1905!1 String)
(assert (= var1905!1 (str.++ var1905 var3701)))
(assert true)
(define-const var943 String (toString/-2075883882 var1845)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(declare-const var1784!2 var3655)
(assert (not (= var1784!2 null-var3655)))
(assert (= (className/1330807122 var1784!2) var943)) ; Statement: r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.spring.Annotations: java.lang.String className> = $r6 
 ; Statement: return 
(check-sat)
; {<init>/1180346878=([java.lang.Enum, java.lang.String, int], void), cast-from-var3655-to-var2169=([org.apache.dubbo.rpc.protocol.tri.rest.support.spring.Annotations], java.lang.Enum), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), name/1633728430=([java.lang.Enum], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), className/1330807122=([org.apache.dubbo.rpc.protocol.tri.rest.support.spring.Annotations], java.lang.String)}
; {var3655=org.apache.dubbo.rpc.protocol.tri.rest.support.spring.Annotations, var1784=r0, var913=r1, var2939=null_type, var1324=i0, var2169=java.lang.Enum, var574=$r2, var1905=$r4, var3701=$r3, var1845=$r5, var943=$r6}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.spring.Annotations=var3655, r0=var1784, r1=var913, null_type=var2939, i0=var1324, java.lang.Enum=var2169, $r2=var574, $r4=var1905, $r3=var3701, $r5=var1845, $r6=var943}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.spring.Annotations;	r1 := @parameter0: java.lang.String;	i0 := @parameter1: int;	specialinvoke r0.<java.lang.Enum: void <init>(java.lang.String,int)>(r1, i0);	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("org.springframework.web.bind.annotation.");	$r3 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.spring.Annotations: java.lang.String name()>();	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.spring.Annotations: java.lang.String className> = $r6;	return
;block_num 1