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

(declare-sort var3446 0)
(declare-sort var193 0)
(declare-sort var1351 0)
(declare-sort var2053 0)
(declare-sort var74 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var193_access$100/-1735106965 (var193) var2053)
(declare-fun ordinal/-291641772 (var74) Int)
(declare-fun cast-from-var2053-to-var74 (var2053) var74)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3446 var3446)
(declare-const null-var193 var193)
(declare-const null-Int Int)
(declare-const null-String String)
(declare-const var1599 var3446) ; Statement: r20 := @this: org.apache.dubbo.qos.textui.TTable 
(assert (not (= var1599 null-var3446)))
(declare-const var1963 var193) ; Statement: r0 := @parameter0: org.apache.dubbo.qos.textui.TTable$ColumnDefine 
(assert (not (= var1963 null-var193)))
(declare-const var2671 Int) ; Statement: i2 := @parameter1: int 
(assert (not (= var2671 null-Int)))
(declare-const var1280 String) ; Statement: r2 := @parameter2: java.lang.String 
(assert (not (= var1280 null-String)))
(define-const var1612 var2053 (var193_access$100/-1735106965 var1963)) ; Statement: $r1 = staticinvoke <org.apache.dubbo.qos.textui.TTable$ColumnDefine: org.apache.dubbo.qos.textui.TTable$Align access$100(org.apache.dubbo.qos.textui.TTable$ColumnDefine)>(r0) 
(assert true)
(define-const var1704 Int (ordinal/-291641772 (cast-from-var2053-to-var74 var1612))) ; Statement: $i0 = virtualinvoke $r1.<org.apache.dubbo.qos.textui.TTable$Align: int ordinal()>() 
 ; Statement: tableswitch($i0) {     case 0: goto $r15 = new java.lang.StringBuilder;     case 1: goto $r10 = new java.lang.StringBuilder;     case 2: goto i1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: int length(java.lang.CharSequence)>(r2);     default: goto $r15 = new java.lang.StringBuilder; } 
(assert true) ; Non Conditional
(define-const var2297 String String-init) ; Statement: $r15 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2297)) ; Statement: specialinvoke $r15.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2297!1 String)
(assert (= var2297!1 ""))
(assert true)
(define-const var973 String (append/672562846 var2297!1 "%-")) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("%-") 
(declare-const var2297!2 String)
(assert (= var2297!2 (str.++ var2297!1 "%-")))
(assert true)
(define-const var3521 String (append/-1001720160 var973 var2671)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i2) 
(declare-const var973!1 String)
(assert (str.prefixof var973 var973!1))
(assert true)
(define-const var1990 String (append/672562846 var3521 "s")) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("s") 
(declare-const var3521!1 String)
(assert (= var3521!1 (str.++ var3521 "s")))
(assert true)
(define-const var2901 String (toString/-2075883882 var1990)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r19 
(check-sat)
; {var193_access$100/-1735106965=([org.apache.dubbo.qos.textui.TTable$ColumnDefine], org.apache.dubbo.qos.textui.TTable$Align), ordinal/-291641772=([java.lang.Enum], int), cast-from-var2053-to-var74=([org.apache.dubbo.qos.textui.TTable$Align], java.lang.Enum), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3446=org.apache.dubbo.qos.textui.TTable, var1599=r20, var193=org.apache.dubbo.qos.textui.TTable$ColumnDefine, var1963=r0, var2671=i2, var1280=r2, var1351=null_type, var2053=org.apache.dubbo.qos.textui.TTable$Align, var1612=$r1, var74=java.lang.Enum, var1704=$i0, var2297=$r15, var973=$r16, var3521=$r17, var1990=$r18, var2901=$r19}
; {org.apache.dubbo.qos.textui.TTable=var3446, r20=var1599, org.apache.dubbo.qos.textui.TTable$ColumnDefine=var193, r0=var1963, i2=var2671, r2=var1280, null_type=var1351, org.apache.dubbo.qos.textui.TTable$Align=var2053, $r1=var1612, java.lang.Enum=var74, $i0=var1704, $r15=var2297, $r16=var973, $r17=var3521, $r18=var1990, $r19=var2901}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r20 := @this: org.apache.dubbo.qos.textui.TTable;	r0 := @parameter0: org.apache.dubbo.qos.textui.TTable$ColumnDefine;	i2 := @parameter1: int;	r2 := @parameter2: java.lang.String;	$r1 = staticinvoke <org.apache.dubbo.qos.textui.TTable$ColumnDefine: org.apache.dubbo.qos.textui.TTable$Align access$100(org.apache.dubbo.qos.textui.TTable$ColumnDefine)>(r0);	$i0 = virtualinvoke $r1.<org.apache.dubbo.qos.textui.TTable$Align: int ordinal()>();	tableswitch($i0) {     case 0: goto $r15 = new java.lang.StringBuilder;     case 1: goto $r10 = new java.lang.StringBuilder;     case 2: goto i1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: int length(java.lang.CharSequence)>(r2);     default: goto $r15 = new java.lang.StringBuilder; };	$r15 = new java.lang.StringBuilder;	specialinvoke $r15.<java.lang.StringBuilder: void <init>()>();	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("%-");	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i2);	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("s");	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.String toString()>();	return $r19
;block_num 2