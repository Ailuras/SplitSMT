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

(declare-sort var1158 0)
(declare-sort var1124 0)
(declare-sort var1380 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var1124_isEmpty/-813097145 (String) Bool)
(declare-fun var1380-init () var1380)
(declare-fun <init>/-1092629202 (var1380 String) void)
(declare-const null-String String)
(declare-const var2486 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2486 null-String)))
(define-const var547 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var547)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var547!1 String)
(assert (= var547!1 ""))
(define-const var871 Bool (var1124_isEmpty/-813097145 var2486)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto r9 = r1 
(assert (not (= (ite var871 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1598 var1380 var1380-init) ; Statement: $r8 = new java.lang.IllegalStateException 
(assert true)
;(assert (<init>/-1092629202 var1598 "service field in configuration is null.")) ; Statement: specialinvoke $r8.<java.lang.IllegalStateException: void <init>(java.lang.String)>("service field in configuration is null.") 

(declare-const var1598!1 var1380)
(declare-const var845 String)
 ; Statement: throw $r8 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var1124_isEmpty/-813097145=([java.lang.String], boolean), var1380-init=([], java.lang.IllegalStateException), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var2486=r1, var1158=null_type, var547=$r0, var1124=org.apache.dubbo.common.utils.StringUtils, var871=$z0, var1380=java.lang.IllegalStateException, var1598=$r8, var845="service field in configuration is null."}
; {r1=var2486, null_type=var1158, $r0=var547, org.apache.dubbo.common.utils.StringUtils=var1124, $z0=var871, java.lang.IllegalStateException=var1380, $r8=var1598, "service field in configuration is null."=var845}
;seq <java.lang.StringBuilder: void <init>()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r1 := @parameter0: java.lang.String;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z0 == 0 goto r9 = r1;	$r8 = new java.lang.IllegalStateException;	specialinvoke $r8.<java.lang.IllegalStateException: void <init>(java.lang.String)>("service field in configuration is null.");	throw $r8
;block_num 2