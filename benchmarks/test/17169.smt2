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

(declare-sort var1001 0)
(declare-sort var2486 0)
(declare-sort var2614 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/1978845529 (var2614 Int String) void)
(declare-fun cast-from-var1001-to-var2614 (var1001) var2614)
(declare-fun unimplemented/2093808741 (var1001) String)
(declare-const null-var1001 var1001)
(declare-const null-String String)
(declare-const var2634 var1001) ; Statement: r0 := @this: org.apache.dubbo.remoting.http12.exception.UnimplementedException 
(assert (not (= var2634 null-var1001)))
(declare-const var1710 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var1710 null-String)))
(define-const var2594 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2594)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2594!1 String)
(assert (= var2594!1 ""))
(assert true)
(define-const var1089 String (append/672562846 var2594!1 "unimplemented ")) ; Statement: $r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("unimplemented ") 
(declare-const var2594!2 String)
(assert (= var2594!2 (str.++ var2594!1 "unimplemented ")))
(assert true)
(define-const var3638 String (append/672562846 var1089 var1710)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var1089!1 String)
(assert (= var1089!1 (str.++ var1089 var1710)))
(assert true)
(define-const var749 String (toString/-2075883882 var3638)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/1978845529 (cast-from-var1001-to-var2614 var2634) 500 var749)) ; Statement: specialinvoke r0.<org.apache.dubbo.remoting.http12.exception.HttpStatusException: void <init>(int,java.lang.String)>(500, $r5) 

(declare-const var2634!1 var1001)
(declare-const var2247 Int)
(declare-const var749!1 String)
(declare-const var2634!2 var1001)
(assert (not (= var2634!2 null-var1001)))
(assert (= (unimplemented/2093808741 var2634!2) var1710)) ; Statement: r0.<org.apache.dubbo.remoting.http12.exception.UnimplementedException: java.lang.String unimplemented> = r2 
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/1978845529=([org.apache.dubbo.remoting.http12.exception.HttpStatusException, int, java.lang.String], void), cast-from-var1001-to-var2614=([org.apache.dubbo.remoting.http12.exception.UnimplementedException], org.apache.dubbo.remoting.http12.exception.HttpStatusException), unimplemented/2093808741=([org.apache.dubbo.remoting.http12.exception.UnimplementedException], java.lang.String)}
; {var1001=org.apache.dubbo.remoting.http12.exception.UnimplementedException, var2634=r0, var1710=r2, var2486=null_type, var2594=$r1, var1089=$r3, var3638=$r4, var749=$r5, var2614=org.apache.dubbo.remoting.http12.exception.HttpStatusException, var2247=500}
; {org.apache.dubbo.remoting.http12.exception.UnimplementedException=var1001, r0=var2634, r2=var1710, null_type=var2486, $r1=var2594, $r3=var1089, $r4=var3638, $r5=var749, org.apache.dubbo.remoting.http12.exception.HttpStatusException=var2614, 500=var2247}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.http12.exception.UnimplementedException;	r2 := @parameter0: java.lang.String;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("unimplemented ");	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke r0.<org.apache.dubbo.remoting.http12.exception.HttpStatusException: void <init>(int,java.lang.String)>(500, $r5);	r0.<org.apache.dubbo.remoting.http12.exception.UnimplementedException: java.lang.String unimplemented> = r2;	return
;block_num 1