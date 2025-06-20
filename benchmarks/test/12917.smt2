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

(declare-sort var1376 0)
(declare-sort var1166 0)
(declare-sort var1787 0)
(declare-sort var1997 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var1787-init () var1787)
(declare-fun <init>/-209206932 (var1787 String) void)
(declare-fun addSuppressed/-2013977960 (var1997 var1997) void)
(declare-const null-var1376 var1376)
(declare-const null-String String)
(declare-const null-var1997 var1997)
(declare-const var1298 var1376) ; Statement: r6 := @this: org.apache.dubbo.qos.textui.TKv 
(assert (not (= var1298 null-var1376)))
(declare-const var3189 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var3189 null-String)))
(define-const var3017 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3017)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3017!1 String)
(assert (= var3017!1 ""))
(define-const var660 var1787 var1787-init) ; Statement: $r1 = new java.util.Scanner 
(assert true)
;(assert (<init>/-209206932 var660 var3189)) ; Statement: specialinvoke $r1.<java.util.Scanner: void <init>(java.lang.String)>(r2) 

(declare-const var660!1 var1787)
(declare-const var3189!1 String)
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3648 var1997) ; Statement: $r5 := @caughtexception 
(assert (not (= var3648 null-var1997)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3274 var1997) ; Statement: $r4 := @caughtexception 
(assert (not (= var3274 null-var1997)))
(assert true)
;(assert (addSuppressed/-2013977960 var3648 var3274)) ; Statement: virtualinvoke $r5.<java.lang.Throwable: void addSuppressed(java.lang.Throwable)>($r4) 

(declare-const var3648!1 var1997)
(declare-const var3274!1 var1997)
(assert true) ; Non Conditional
 ; Statement: throw $r5 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var1787-init=([], java.util.Scanner), <init>/-209206932=([java.util.Scanner, java.lang.String], void), addSuppressed/-2013977960=([java.lang.Throwable, java.lang.Throwable], void)}
; {var1376=org.apache.dubbo.qos.textui.TKv, var1298=r6, var3189=r2, var1166=null_type, var3017=$r0, var1787=java.util.Scanner, var660=$r1, var1997=java.lang.Throwable, var3648=$r5, var3274=$r4}
; {org.apache.dubbo.qos.textui.TKv=var1376, r6=var1298, r2=var3189, null_type=var1166, $r0=var3017, java.util.Scanner=var1787, $r1=var660, java.lang.Throwable=var1997, $r5=var3648, $r4=var3274}
;seq <java.lang.StringBuilder: void <init>()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1}
;stmts r6 := @this: org.apache.dubbo.qos.textui.TKv;	r2 := @parameter0: java.lang.String;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r1 = new java.util.Scanner;	specialinvoke $r1.<java.util.Scanner: void <init>(java.lang.String)>(r2);	$r5 := @caughtexception;	$r4 := @caughtexception;	virtualinvoke $r5.<java.lang.Throwable: void addSuppressed(java.lang.Throwable)>($r4);	throw $r5
;block_num 4