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

(declare-sort var369 0)
(declare-sort var2220 0)
(declare-sort var3656 0)
(declare-sort var2231 0)
(declare-sort var580 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2220_access$100/-1735106965 (var2220) var2231)
(declare-fun ordinal/-291641772 (var580) Int)
(declare-fun cast-from-var2231-to-var580 (var2231) var580)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var369 var369)
(declare-const null-var2220 var2220)
(declare-const null-Int Int)
(declare-const null-String String)
(declare-const var3837 var369) ; Statement: r20 := @this: org.apache.dubbo.qos.textui.TTable 
(assert (not (= var3837 null-var369)))
(declare-const var1960 var2220) ; Statement: r0 := @parameter0: org.apache.dubbo.qos.textui.TTable$ColumnDefine 
(assert (not (= var1960 null-var2220)))
(declare-const var1569 Int) ; Statement: i2 := @parameter1: int 
(assert (not (= var1569 null-Int)))
(declare-const var1905 String) ; Statement: r2 := @parameter2: java.lang.String 
(assert (not (= var1905 null-String)))
(define-const var3293 var2231 (var2220_access$100/-1735106965 var1960)) ; Statement: $r1 = staticinvoke <org.apache.dubbo.qos.textui.TTable$ColumnDefine: org.apache.dubbo.qos.textui.TTable$Align access$100(org.apache.dubbo.qos.textui.TTable$ColumnDefine)>(r0) 
(assert true)
(define-const var3405 Int (ordinal/-291641772 (cast-from-var2231-to-var580 var3293))) ; Statement: $i0 = virtualinvoke $r1.<org.apache.dubbo.qos.textui.TTable$Align: int ordinal()>() 
 ; Statement: tableswitch($i0) {     case 0: goto $r15 = new java.lang.StringBuilder;     case 1: goto $r10 = new java.lang.StringBuilder;     case 2: goto i1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: int length(java.lang.CharSequence)>(r2);     default: goto $r15 = new java.lang.StringBuilder; } 
(assert (and (= var3405 1) (and (not (= var3405 0)) true))) ; Intersect: Cond: $i0 == 1  and Intersect: Negate: Cond: $i0 == 0   and Non Conditional  
(define-const var2817 String String-init) ; Statement: $r10 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2817)) ; Statement: specialinvoke $r10.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2817!1 String)
(assert (= var2817!1 ""))
(assert true)
(define-const var2130 String (append/672562846 var2817!1 "%")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("%") 
(declare-const var2817!2 String)
(assert (= var2817!2 (str.++ var2817!1 "%")))
(assert true)
(define-const var1149 String (append/-1001720160 var2130 var1569)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i2) 
(declare-const var2130!1 String)
(assert (str.prefixof var2130 var2130!1))
(assert true)
(define-const var2532 String (append/672562846 var1149 "s")) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("s") 
(declare-const var1149!1 String)
(assert (= var1149!1 (str.++ var1149 "s")))
(assert true)
(define-const var2909 String (toString/-2075883882 var2532)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r14 
(check-sat)
; {var2220_access$100/-1735106965=([org.apache.dubbo.qos.textui.TTable$ColumnDefine], org.apache.dubbo.qos.textui.TTable$Align), ordinal/-291641772=([java.lang.Enum], int), cast-from-var2231-to-var580=([org.apache.dubbo.qos.textui.TTable$Align], java.lang.Enum), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var369=org.apache.dubbo.qos.textui.TTable, var3837=r20, var2220=org.apache.dubbo.qos.textui.TTable$ColumnDefine, var1960=r0, var1569=i2, var1905=r2, var3656=null_type, var2231=org.apache.dubbo.qos.textui.TTable$Align, var3293=$r1, var580=java.lang.Enum, var3405=$i0, var2817=$r10, var2130=$r11, var1149=$r12, var2532=$r13, var2909=$r14}
; {org.apache.dubbo.qos.textui.TTable=var369, r20=var3837, org.apache.dubbo.qos.textui.TTable$ColumnDefine=var2220, r0=var1960, i2=var1569, r2=var1905, null_type=var3656, org.apache.dubbo.qos.textui.TTable$Align=var2231, $r1=var3293, java.lang.Enum=var580, $i0=var3405, $r10=var2817, $r11=var2130, $r12=var1149, $r13=var2532, $r14=var2909}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r20 := @this: org.apache.dubbo.qos.textui.TTable;	r0 := @parameter0: org.apache.dubbo.qos.textui.TTable$ColumnDefine;	i2 := @parameter1: int;	r2 := @parameter2: java.lang.String;	$r1 = staticinvoke <org.apache.dubbo.qos.textui.TTable$ColumnDefine: org.apache.dubbo.qos.textui.TTable$Align access$100(org.apache.dubbo.qos.textui.TTable$ColumnDefine)>(r0);	$i0 = virtualinvoke $r1.<org.apache.dubbo.qos.textui.TTable$Align: int ordinal()>();	tableswitch($i0) {     case 0: goto $r15 = new java.lang.StringBuilder;     case 1: goto $r10 = new java.lang.StringBuilder;     case 2: goto i1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: int length(java.lang.CharSequence)>(r2);     default: goto $r15 = new java.lang.StringBuilder; };	$r10 = new java.lang.StringBuilder;	specialinvoke $r10.<java.lang.StringBuilder: void <init>()>();	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("%");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i2);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("s");	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>();	return $r14
;block_num 2