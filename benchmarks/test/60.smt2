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

(declare-sort var2291 0)
(declare-sort var932 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var932_appendEscapedCodePoint/-224255266 (String Int String) void)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-Int Int)
(declare-const null-String String)
(declare-const var3603 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var3603 null-Int)))
(declare-const var2283 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var2283 null-String)))
(define-const var3588 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3588)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3588!1 String)
(assert (= var3588!1 ""))
;(assert (var932_appendEscapedCodePoint/-224255266 var3588!1 var3603 var2283)) ; Statement: staticinvoke <org.antlr.v4.codegen.UnicodeEscapes: void appendEscapedCodePoint(java.lang.StringBuilder,int,java.lang.String)>($r0, i0, r1) 

(declare-const var3588!2 String)
(declare-const var3603!1 Int)
(declare-const var2283!1 String)
(assert true)
(define-const var2933 String (toString/-2075883882 var3588!2)) ; Statement: $r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r2 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var932_appendEscapedCodePoint/-224255266=([java.lang.StringBuilder, int, java.lang.String], void), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3603=i0, var2283=r1, var2291=null_type, var3588=$r0, var932=org.antlr.v4.codegen.UnicodeEscapes, var2933=$r2}
; {i0=var3603, r1=var2283, null_type=var2291, $r0=var3588, org.antlr.v4.codegen.UnicodeEscapes=var932, $r2=var2933}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts i0 := @parameter0: int;	r1 := @parameter1: java.lang.String;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	staticinvoke <org.antlr.v4.codegen.UnicodeEscapes: void appendEscapedCodePoint(java.lang.StringBuilder,int,java.lang.String)>($r0, i0, r1);	$r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r2
;block_num 1